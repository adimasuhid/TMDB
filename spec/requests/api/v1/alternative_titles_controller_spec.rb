require 'spec_helper'

describe Api::V1::AlternativeTitlesController do
  let!(:language) { create :language }
  let!(:alternative_title) { create :alternative_title, language: language}

  describe "#index" do
    it "assigns @alternative_titles" do
      get "/api/v1/alternative_titles.json"
      expect(assigns(:alternative_titles)).to include alternative_title
    end

    it "assigns @languages" do
      get "/api/v1/alternative_titles.json"
      expect(assigns(:languages)).to include language
    end

    it "has 200 status" do
      get "/api/v1/alternative_titles.json"
      expect(response).to be_success
    end
  end
end
