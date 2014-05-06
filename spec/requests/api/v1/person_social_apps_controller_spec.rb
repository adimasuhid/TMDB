require 'spec_helper'

describe Api::V1::PersonSocialAppsController do
  let!(:social_app) { create :social_app }
  let!(:person) { create :person }
  let!(:person_social_app) { create :person_social_app, social_app: social_app, person: person }

  describe "#index" do
    it "assigns @person_social_apps" do
      get "/api/v1/person_social_apps.json"
      expect(assigns(:person_social_apps)).to include person_social_app
    end

    it "assigns @social_apps" do
      get "/api/v1/person_social_apps.json"
      expect(assigns(:social_apps)).to include social_app
    end

    it "assigns @people" do
      get "/api/v1/person_social_apps.json"
      expect(assigns(:people)).to include person
    end
  end
end
