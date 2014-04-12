require 'spec_helper'

describe ApplicationController do
  controller do
    def index

    end
  end

  describe "#init_cache" do
    it "assigns @cache to a new Memcached" do
      expect(assigns(:cache)).to be_an_instance_of Memcached
    end
  end
end
