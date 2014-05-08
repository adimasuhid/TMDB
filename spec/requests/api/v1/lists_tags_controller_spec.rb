require 'spec_helper'

describe Api::V1::ListTagsController do
  let!(:admin_user) { create :user }
  let!(:list_tag) { create :list_tag }

  describe "#create" do
    it "returns success status" do
      post "/api/v1/list_tags", list_tag: { temp_user_id: 2 }, tag_ids: [1,2], tag_types: [1,2]
      expect(JSON.parse(response.body)).to eq({ "status" => "success" })
    end

    it "creates a ListTag" do
      expect do
        post "/api/v1/list_tags", list_tag: { temp_user_id: "2"}, tag_ids: [1,2], tag_types: [1,2]
      end.to change(ListTag, :count).by(2)
    end
  end

  describe "#update" do
    context "user is not admin/moderator" do
      it "returns nil" do
        put "/api/v1/list_tags/#{list_tag.id}", list_tag: { temp_user_id: 2 }
        expect(response.body).to eq " "
      end
    end

    context "user is admin" do
      before :each do
        admin_user.user_type = "admin"
        admin_user.save
        allow_any_instance_of(Api::V1::ListTagsController).to receive(:current_api_user).and_return(admin_user)
      end

      context "no list tag" do
        it "returns error" do
          put "/api/v1/list_tags/#{list_tag.id}", list_tag: { temp_user_id: 2 }
          expect(JSON.parse(response.body)).to eq({ "status" => "error" })
        end
      end

      context "with list tag" do
        it "returns success"
      end

    end
  end
end
