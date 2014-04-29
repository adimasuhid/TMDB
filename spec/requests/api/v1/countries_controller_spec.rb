require 'spec_helper'

describe Api::V1::CountriesController do
  let!(:country) { create :country }

  describe "#search" do
    it "returns hash of label, value and id" do
      get "/api/v1/countries/search.json", term: "string"
      expect(JSON.parse(response.body)).to include({ "label" => country.country, "value" => country.country, "id" => country.id })
    end
  end

end
