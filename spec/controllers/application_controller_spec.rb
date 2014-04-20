require 'spec_helper'

describe ApplicationController do
  controller do
    def index

    end
  end

  describe "#init_cache" do
    it "assigns @cache to a new Memcached" do
      expect_any_instance_of(Memcached).to receive(:initialize).with("localhost:11211")

      get :index
    end
  end
end
