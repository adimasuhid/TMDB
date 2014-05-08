require 'spec_helper'

describe ApplicationController do
  let!(:user) { create :user }

  describe "#init_cache" do
    it "assigns @cache to a new Memcached" do
      get :index
      expect(assigns(:cache)).to be_an_instance_of Memcached
    end
  end

  describe "#authenticate_admin_user!" do
    context "user is admin" do
      it "returns nil" do
        user.user_type = "admin"
        user.save
        controller.stub(:current_user).and_return(user)
        expect(controller.authenticate_admin_user!).to be_nil
      end
    end

    context "user is not admin" do
      it "calls a redirect to root path" do
        controller.stub(:current_user).and_return(user)
        expect(controller).to receive(:redirect_to).at_least :once
        controller.authenticate_admin_user!
      end
    end
  end
end
