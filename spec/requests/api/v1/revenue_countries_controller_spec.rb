require 'spec_helper'

describe Api::V1::RevenueCountriesController do
  let!(:country) { create :country }
  let!(:revenue_country) { create :revenue_country, country: country }

  describe "#index" do
    it "assigns @revenue_countries" do
      get "/api/v1/revenue_countries.json"
      expect(assigns(:revenue_countries)).to include revenue_country
    end

    it "assigns @countries" do
      get "/api/v1/revenue_countries.json"
      expect(assigns(:countries)).to include country
    end
  end
end
