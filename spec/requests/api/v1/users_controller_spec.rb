require 'spec_helper'

describe Api::V1::UsersController do
  let!(:user) { create :user }
  let!(:admin_user) { create :user, email: "wat@yahoo.com" }

  describe "#show" do
    it "assigns user" do
      get "/api/v1/users/#{user.id}", { moderate: true }
      expect(assigns(:user)).to eq user
    end
  end

  describe "#update" do
    it "returns a user" do
      get "/api/v1/users/#{user.id}", { moderate: true }
      expect(JSON.parse(response.body).keys).to include "user"
    end
  end

  describe "#get_current_user" do
    it "assigns user" do
      get "/api/v1/users/get_current_user", { moderate: true }
      expect(assigns(:user)).to eq []
    end
  end

  describe "#toggle_active" do
    before :each do
      allow_any_instance_of(Api::V1::UsersController).to receive(:current_api_user).and_return(user)
    end

    it "returns user" do
      put "/api/v1/users/#{user.id}/toggle_active", { moderate: true, user: { toggle_active: true } }
      expect(response.body).to eq ""
    end
  end
end
