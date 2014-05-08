require 'spec_helper'

describe Api::V1::LocksController do
  let!(:user) { create :user }
  let!(:movie) { create :movie }

  describe "#mark" do
    context "user is not an admin" do
      it "renders error" do
        allow_any_instance_of(Api::V1::LocksController).to receive(:current_api_user).and_return(user)
        post "/api/v1/locks/mark"
        expect(response.body).to eq "Error: current user is not admin or moderator."
      end
    end

    context "user is an admin" do
      before :each do
        user.user_type="admin"
        user.save
        allow_any_instance_of(Api::V1::LocksController).to receive(:current_api_user).and_return(user)
      end

      context "item is saved" do
        it "returns movie" do
          post "/api/v1/locks/mark", item_type: "Movie", item_id: movie.id
          expect(JSON.parse(response.body)["id"]).to eq movie.id
        end
      end

      context "item is not saved" do
        it "returns error" do
          expect_any_instance_of(Movie).to receive(:save).and_return(false)
          post "/api/v1/locks/mark", item_type: "Movie", item_id: movie.id
          expect(response.body).to eq "Error saving item."
        end
      end
    end
  end
end
