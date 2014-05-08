require 'spec_helper'

describe Api::V1::TagsController do
  let!(:movie) { create :movie }
  let!(:person) { create :person }
  let!(:tag) { create :tag, taggable_type: "Movie", taggable_id: movie.id, person_id: person.id }

  describe "#index" do
    it "assigns @tags" do
      get "/api/v1/tags"
      expect(assigns(:tags)).to include tag
    end

    it "assigns @movies" do
      get "/api/v1/tags"
      expect(assigns(:movies)).to include movie
    end

    it "assigns @people" do
      get "/api/v1/tags"
      expect(assigns(:people)).to include person
    end
  end

  describe "#show" do
    it "assigns @tag" do
      get "/api/v1/tags/#{tag.id}"
      expect(assigns(:tag)).to eq tag
    end

    it "assigns @movies" do
      get "/api/v1/tags/#{tag.id}"
      expect(assigns(:movies)).to include movie
    end

    it "assigns @people" do
      get "/api/v1/tags/#{tag.id}"
      expect(assigns(:people)).to include person
    end
  end
end
