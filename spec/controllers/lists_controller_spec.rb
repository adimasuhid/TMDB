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
        expect(controller.instance_variable_get(:@lists)).to_not be_nil
      end

      it "responds with a 200 status" do
        get :index
        expect(response.status).to eq 200
      end
    end
  end

  describe "#galleries" do
    it "assigns @index_title" do
      get :galleries
      expect(controller.instance_variable_get(:@index_title)).to eq("Galleries")
    end

    context "with a cache" do
      it "assigns @lists" do
        expect_any_instance_of(Memcached).to receive(:get).with("static_galleries").and_return("test")
        get :galleries
        expect(controller.instance_variable_get(:@lists)).to eq("test")
      end

      it "responds with a 200 status" do
        get :galleries
        expect(response.status).to eq 200
      end
    end

    context "without a cache" do
      it "assigns @lists" do
        get :galleries
        expect(controller.instance_variable_get(:@lists)).to_not be_nil
      end

      it "responds with a 200 status" do
        get :galleries
        expect(response.status).to eq 200
      end
    end

  end

  describe "#channels" do
    it "assigns @index_title" do
      get :channels
      expect(controller.instance_variable_get(:@index_title)).to eq("Channels")
    end

    context "with a cache" do
      it "assigns @lists" do
        expect_any_instance_of(Memcached).to receive(:get).with("static_channels").and_return("test")
        get :channels
        expect(controller.instance_variable_get(:@lists)).to eq("test")
      end

      it "responds with a 200 status" do
        get :channels
        expect(response.status).to eq 200
      end
    end

    context "without a cache" do
      it "assigns @lists" do
        get :channels
        expect(controller.instance_variable_get(:@lists)).to_not be_nil
      end

      it "responds with a 200 status" do
        get :galleries
        expect(response.status).to eq 200
      end
    end

  end

end
