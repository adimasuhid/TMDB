require 'spec_helper'

describe ListsController do
  let!(:list) { build :list }

  describe "#index" do
    context "with a cache" do
      it "assigns @lists" do
        expect_any_instance_of(Memcached).to receive(:get).with("static_lists").and_return("test")
        get :index
        expect(controller.instance_variable_get(:@lists)).to eq("test")
      end

      it "responds with a 200 status" do
        get :index
        expect(response.status).to eq 200
      end
    end

    context "without a cache" do
      it "assigns @lists" do
        get :index
        expect(controller.instance_variable_get(:@lists)).to be_an_instance_of ActiveRecord::Relation
      end

      it "responds with a 200 status" do
        get :index
        expect(response.status).to eq 200
      end
    end
  end

end
