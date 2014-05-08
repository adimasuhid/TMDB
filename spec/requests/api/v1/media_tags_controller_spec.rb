require 'spec_helper'

describe Api::V1::MediaTagsController do
  let!(:user) { create :user }
  let!(:media_tag) { create :media_tag, user_id: user.id }

  describe "#create" do
    it "returns success status" do
      post "/api/v1/media_tags", media_tag: { temp_user_id: 2 }, tag_ids: [1,2], tag_types: [1,2]
      expect(JSON.parse(response.body)).to eq({ "status" => "success" })
    end

    it "creates a MediaTag" do
      expect do
        post "/api/v1/media_tags", media_tag: { temp_user_id: 2 }, tag_ids: [1,2], tag_types: [1,2]
      end.to change(MediaTag, :count).by(2)
    end
  end

  describe "#destroy" do
    before :each do
      allow_any_instance_of(Api::V1::MediaTagsController).to receive(:current_api_user).and_return(user)
    end

    context "successful destroy" do
      it "returns success" do
        delete "/api/v1/media_tags/#{media_tag.id}", media_tag: {
          temp_user_id: 2
        }

        expect(JSON.parse(response.body)).to eq({ "status" => "success" })
      end
    end


    context "erroneous destroy" do
      it "returns error" do
        allow_any_instance_of(ActiveRecord::Relation).to receive(:destroy_all).and_return(false)

        delete "/api/v1/media_tags/#{media_tag.id}", media_tag: {
          temp_user_id: 2
        }

        expect(JSON.parse(response.body)).to eq({ "status" => "error" })
      end
    end

  end
end
