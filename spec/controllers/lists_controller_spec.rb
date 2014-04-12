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

  describe "#show" do
    before :each do
      list.save
      list.reload
    end

    context "with a cache" do
      it "gets multiple instance objects from cache" do
        expect_any_instance_of(Memcached).to receive(:get).with("list/#{list.id}")
        expect_any_instance_of(Memcached).to receive(:get).with("list/#{list.id}/movies")
        expect_any_instance_of(Memcached).to receive(:get).with("list/#{list.id}/people")
        expect_any_instance_of(Memcached).to receive(:get).with("list/#{list.id}/images")
        expect_any_instance_of(Memcached).to receive(:get).with("list/#{list.id}/videos")
        expect_any_instance_of(Memcached).to receive(:get).with("list/#{list.id}/keywords")
        expect_any_instance_of(Memcached).to receive(:get).with("list/#{list.id}/tags")
        get :show, id: list
      end
    end

    context "without a cache" do
      it "assigns @list" do
        list.approved = true
        list.save
        list.reload

        get :show, id: list.id
        expect(controller.instance_variable_get(:@list)).to eq List.first
      end

      context "with list" do
        before :each do
          list.approved = true
          list.save
          list.reload
        end

        it "assigns @movies" do
          get :show, id: list.id
          expect(controller.instance_variable_get(:@movies)).to_not be_nil
        end

        it "assigns @people" do
          get :show, id: list.id
          expect(controller.instance_variable_get(:@people)).to_not be_nil
        end

        it "assigns @images" do
          get :show, id: list.id
          expect(controller.instance_variable_get(:@images)).to_not be_nil
        end

        it "assigns @videos" do
          get :show, id: list.id
          expect(controller.instance_variable_get(:@keywords)).to_not be_nil
        end

        it "assigns @keywords" do
          get :show, id: list.id
          expect(controller.instance_variable_get(:@keywords)).to_not be_nil
        end

        it "assigns @tags" do
          get :show, id: list.id
          expect(controller.instance_variable_get(:@tags)).to_not be_nil
        end

      end

      context "without a list" do
        before :each do
          list.save
          list.reload
          get :show, id: list
        end

        it "assigns @movies to empty array" do
          expect(controller.instance_variable_get(:@movies)).to eq []
        end

        it "assigns @people to empty array" do
          expect(controller.instance_variable_get(:@people)).to eq []
        end

        it "assigns @images to empty array" do
          expect(controller.instance_variable_get(:@images)).to eq []
        end

        it "assigns @videos to empty array" do
          expect(controller.instance_variable_get(:@videos)).to eq []
        end

        it "assigns @keywords to empty array" do
          expect(controller.instance_variable_get(:@keywords)).to eq []
        end

        it "assigns @tags to empty array" do
          expect(controller.instance_variable_get(:@tags)).to eq []
        end
      end
    end

  end

end
