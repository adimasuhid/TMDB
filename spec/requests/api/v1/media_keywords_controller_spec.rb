require 'spec_helper'

describe Api::V1::MediaKeywordsController do
  let!(:keyword) { create :keyword }
  let!(:user) { create :user }
  let!(:media_keyword) { create :media_keyword, keyword_id: keyword.id, user_id: user.id }

  describe "#index" do
    pending #no output, no template
  end

  describe "#create" do

    it "returns success" do
      post "/api/v1/media_keywords", media_keyword: { temp_user_id: 2 }, keyword_ids: [1,2]
      expect(JSON.parse(response.body)).to eq({ "status" => "success" })
    end

    it "creates a media keyword" do
      expect do
        post "/api/v1/media_keywords", media_keyword: { temp_user_id: 2 }, keyword_ids: [1,2]
      end.to change(MediaKeyword, :count).by(2)

    end
  end

  describe "#destroy" do
    before :each do
      user.user_type = "admin"
      user.save
      allow_any_instance_of(Api::V1::MediaKeywordsController).to receive(:current_api_user).and_return(user)
    end

    context "successful destroy" do
      it "returns success" do
        delete "/api/v1/media_keywords/#{media_keyword.id}"
        expect(JSON.parse(response.body)).to eq({ "status" => "success" })
      end
    end

    context "erroneous destroy" do
      it "returns error" do
        allow_any_instance_of(ActiveRecord::Relation).to receive(:destroy_all).and_return(false)
        delete "/api/v1/media_keywords/#{media_keyword.id}"
        expect(JSON.parse(response.body)).to eq({ "status" => "error" })
      end
    end

  end
end
