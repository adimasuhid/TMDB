require 'spec_helper'

describe Api::V1::ReleasesController do
  let!(:country) { create :country }
  let!(:release) { create :release, country: country }

  describe "#index" do
    it "assigns @releases" do
      get "/api/v1/releases.json"
      expect(assigns(:releases)).to include release
    end

    it "assigns @countries" do
      get "/api/v1/releases.json"
      expect(assigns(:countries)).to include country
    end
  end
end
