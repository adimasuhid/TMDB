require 'spec_helper'

describe Api::V1::CastsController do
  let!(:person) { create :person }
  let!(:movie) { create :movie }
  let!(:cast) { create :cast, movie_id: movie.id, person_id: person.id }

  describe "#index" do
    it "assigns casts" do
      get "/api/v1/casts.json"
      expect(assigns(:casts)).to include cast
    end

    it "assigns people" do
      get "/api/v1/casts.json"
      expect(assigns(:people)).to include person
    end

    it "assigns movies" do
      get "/api/v1/casts.json"
      expect(assigns(:movies)).to include movie
    end
  end
end
