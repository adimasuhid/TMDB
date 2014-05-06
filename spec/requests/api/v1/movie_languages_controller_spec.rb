require 'spec_helper'

describe Api::V1::MovieLanguagesController do
  let!(:language) { create :language }
  let!(:movie_language) { create :movie_language, language: language }

  describe "#index" do
    it "assigns @movie_languages" do
      get "/api/v1/movie_languages.json"
      expect(assigns(:movie_languages)).to include movie_language
    end

    it "assigns @languages" do
      get "/api/v1/movie_languages.json"
      expect(assigns(:languages)).to include language
    end
  end
end
