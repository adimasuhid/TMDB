require 'spec_helper'

describe Api::V1::ProductionCompaniesController do
  let!(:company) { create :company }
  let!(:production_company) { create :production_company, company: company }

  describe "#index" do
    it "assigns @production_companies" do
      get "/api/v1/production_companies.json"
      expect(assigns(:production_companies)).to include production_company
    end

    it "assings @company" do
      get "/api/v1/production_companies.json"
      expect(assigns(:companies)).to include company
    end
  end
end
