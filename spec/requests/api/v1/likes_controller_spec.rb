require 'spec_helper'

describe Api::V1::LikesController do
  let!(:user) { create :user }
  let!(:like) { create :like, user_id: user.id, temp_user_id: nil }

  describe "#index" do
    it "returns likes" do
      allow_any_instance_of(Api::V1::LikesController).to receive(:current_api_user).and_return(user)
      get "/api/v1/likes", like: { likable_type: "MyString", likable_id: 1 }
      expect(response.body).to include(like.to_json)
    end
  end

  describe "#create" do
    context "like is saved" do
      it "returns like, likes, and dislikes" do
        allow_any_instance_of(Api::V1::LikesController).to receive(:current_api_user).and_return(user)
        like.id = 3

        post "/api/v1/likes", like: { likable_type: "MyString", likable_id: 1, status: 1 }
        expect(JSON.parse(response.body)).to eq({ "like" => JSON.parse(like.to_json), "likes" => 1, "dislikes" => 0})
      end
    end

    context "like is not saved" do
      it "returns error" do
        allow_any_instance_of(Api::V1::LikesController).to receive(:current_api_user).and_return(user)
        allow_any_instance_of(Like).to receive(:save).and_return(false)

        post "/api/v1/likes", like: { likable_type: "MyString", likable_id: 1, status: 1 }
        expect(response.body).to eq("Error saving like.")
      end
    end
  end
end
