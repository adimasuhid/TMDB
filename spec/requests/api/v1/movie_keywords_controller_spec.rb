require 'spec_helper'

describe Api::V1::MovieKeywordsController do
  let!(:keyword) { create :keyword }
  let!(:movie_keyword) { create :movie_keyword, keyword: keyword }

  describe "#index" do
    it "assigns @movie_keywords" do
      get "/api/v1/movie_keywords.json"
      expect(assigns(:movie_keywords)).to include movie_keyword
    end

    it "assigns @keywords" do
      get "/api/v1/movie_keywords.json"
      expect(assigns(:keywords)).to include keyword
    end
  end
end
