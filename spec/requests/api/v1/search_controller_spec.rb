require 'spec_helper'

describe Api::V1::SearchController do
  let!(:movie) { create :movie, approved: true }
  let!(:person) { create :person, approved: true  }

  describe "#search" do
    context "with related search term" do
      it "returns person" do
        get "/api/v1/search.json", term: "mystring"
        expect(JSON.parse(response.body)).to include({ "id" => person.id, "value" => person.name, "type" => "Person" })
      end

      it "returns movie" do
        get "/api/v1/search.json", term: "mystring"
        expect(JSON.parse(response.body)).to include({ "id" => movie.id, "value" => movie.title, "type" => "Movie" })
      end
    end

    context "with unrelated search terms" do
      it "returns an empty array" do
        get "/api/v1/search.json", term: "lalala"
        expect(JSON.parse(response.body)).to eq([])
      end
    end
  end
end
