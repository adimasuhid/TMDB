require 'spec_helper'

describe Api::V1::CompaniesController do
  let!(:company) { create :company }

  describe "#search" do
    it "returns hash of label, value and id" do
      get "/api/v1/companies/search.json", term: "string"
      expect(JSON.parse(response.body)).to include({ "label" => company.company, "value" => company.company, "id" => company.id })
    end
  end

end
