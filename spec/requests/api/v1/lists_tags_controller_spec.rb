require 'spec_helper'

describe Api::V1::ListTagsController do
  describe "#create" do
    it "returns success status" do
      post "/api/v1/list_tags", list_tag: { temp_user_id: "2"}, tag_ids: [1,2], tag_types: [1,2]
      expect(JSON.parse(response.body)).to eq({ "status" => "success" })
    end

    it "creates a ListTag" do
      expect do
        post "/api/v1/list_tags", list_tag: { temp_user_id: "2"}, tag_ids: [1,2], tag_types: [1,2]
      end.to change(ListTag, :count).by(2)
    end
  end
end
