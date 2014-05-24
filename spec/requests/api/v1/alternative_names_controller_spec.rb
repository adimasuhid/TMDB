require 'spec_helper'

describe Api::V1::AlternativeNamesController do
  let!(:person) { create :person }
  let!(:alternative_name) { create :alternative_name, person: person }

  describe "#index" do
    it "assigns @alternative_names" do
      get "/api/v1/alternative_names.json"
      expect(assigns(:alternative_names)).to include alternative_name
    end

    it "assigns @people" do
      get "/api/v1/alternative_names.json"
      expect(assigns(:people)).to include person
    end

    it "has 200 status" do
      get "/api/v1/alternative_names.json"
      expect(response).to be_success
    end
  end
end
