require 'spec_helper'

describe Api::V1::MovieGenresController do
  let!(:genre) { create :genre }
  let!(:movie_genre) { create :movie_genre, genre: genre }

  describe "#index" do
    it "assigns @movie_genres" do
      get "/api/v1/movie_genres.json"
      expect(assigns(:movie_genres)).to include movie_genre
    end

    it "assigns @genres" do
      get "/api/v1/movie_genres.json"
      expect(assigns(:genres)).to include genre
    end
  end
end
