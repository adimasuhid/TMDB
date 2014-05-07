require 'spec_helper'

describe Api::V1::SocialAppsController do
  let!(:social_app) { create :social_app }

  describe "#search" do
    context "with related search term" do
      it "returns social_app" do
        get "/api/v1/social_apps/search.json", term: "mystring"
        expect(JSON.parse(response.body)).to include({ "label" => social_app.social_app, "value" => social_app.social_app, "id" => social_app.id})
      end
    end

    context "with unrelated search term" do
      it "retunrs an empty array" do
        get "/api/v1/social_apps/search.json", term: "lalala"
        expect(JSON.parse(response.body)).to eq []
      end
    end
  end
end
