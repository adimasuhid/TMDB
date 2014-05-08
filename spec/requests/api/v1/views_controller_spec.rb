require 'spec_helper'

describe Api::V1::ViewsController do
  describe "#create" do
    it "returns nil" do
      post "/api/v1/views", view: { temp_user_id: 1, viewable_type: "lala", viewable_id: 2}
      expect(response.body).to eq " "
    end

    it "creates a view" do
      expect do
        post "/api/v1/views", view: { temp_user_id: 1, viewable_type: "lala", viewable_id: 2}
      end.to change(View, :count).by(1)
    end
  end
end
