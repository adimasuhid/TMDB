require 'spec_helper'

describe Api::V1::CrewsController do
  let!(:person) { create :person }
  let!(:movie) { create :movie }
  let!(:crew) { create :crew, movie_id: movie.id, person_id: person.id }

  describe "#index" do
    it "assigns crew" do
      get "/api/v1/crews.json"
      expect(assigns(:crews)).to include crew
    end

    it "assigns people" do
      get "/api/v1/crews.json"
      expect(assigns(:people)).to include person
    end

    it "assigns movies" do
      get "/api/v1/crews.json"
      expect(assigns(:movies)).to include movie
    end
  end
end
