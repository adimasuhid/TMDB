require 'spec_helper'

describe Api::V1::TagsController do
  let!(:movie) { create :movie }
  let!(:person) { create :person }
  let!(:company) { create :company }
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

  describe "#search" do
    it "includes movie" do
      #movie.original_id = movie.id
      #movie.save
      get "/api/v1/tags/search", { term: "mystring" }
      expect(JSON.parse(response.body)).to include({ "id" => movie.id, "value" => movie.title, "type" => "Movie" })
    end

    it "includes person" do
      get "/api/v1/tags/search", { term: "mystring" }
      expect(JSON.parse(response.body)).to include({ "id" => person.id, "value" => person.name, "type" => "Person" })
    end

    it "includes commpany" do
      get "/api/v1/tags/search", { term: "mystring" }
      expect(JSON.parse(response.body)).to include({ "id" => company.id, "value" => company.company, "type" => "Company" })
    end
  end
end
