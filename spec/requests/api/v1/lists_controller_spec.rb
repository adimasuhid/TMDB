require 'spec_helper'

describe Api::V1::ListsController do
  let!(:user) { create :user }
  let!(:list) { create :list, user_id: user.id }
  let!(:approved_list) { create :list, list_type: nil, approved: true, user_id: user.id }
  let!(:gallery_list) { create :list, list_type: "gallery", approved: true, user_id: user.id }
  let!(:channel_list) { create :list, list_type: "channel", approved: true, user_id: user.id }

  describe "#index" do
    context "with cached content" do
      it "assigns list with cached content" do
        allow_any_instance_of(Memcached).to receive(:get).and_return(list)
        get "/api/v1/lists.json"
        expect(assigns(:lists)).to eq list
      end
    end

    context "without cached content" do
      it "assigns list" do
        get "/api/v1/lists.json"
        expect(assigns(:lists)).to include approved_list
      end
    end
  end

  describe "#galleries" do
    context "with cached content" do
      it "assigns list with cached content" do
        allow_any_instance_of(Memcached).to receive(:get).and_return([list])
        get "/api/v1/lists/galleries.json"
        expect(assigns(:lists)).to eq [list]
      end
    end

    context "without cached content" do
      it "assigns list" do
        get "/api/v1/lists/galleries.json"
        expect(assigns(:lists)).to include gallery_list
      end
    end
  end

  describe "#channels" do
    context "with cached content" do
      it "assigns list with cached content" do
        allow_any_instance_of(Memcached).to receive(:get).and_return([list])
        get "/api/v1/lists/channels.json"
        expect(assigns(:lists)).to eq [list]
      end
    end

    context "without cached content" do
      it "assigns list" do
        get "/api/v1/lists/channels.json"
        expect(assigns(:lists)).to include channel_list
      end
    end
  end

  describe "#show" do
    it "assigns @movies" do
      get "/api/v1/lists/#{list.id}"
      expect(assigns(:movies)).to_not be_nil
    end

    it "assigns @people" do
      get "/api/v1/lists/#{list.id}"
      expect(assigns(:people)).to_not be_nil
    end

    it "assigns @images" do
      get "/api/v1/lists/#{list.id}"
      expect(assigns(:images)).to_not be_nil
    end

    it "assigns @videos" do
      get "/api/v1/lists/#{list.id}"
      expect(assigns(:videos)).to_not be_nil
    end

    it "assigns @keywords" do
      get "/api/v1/lists/#{list.id}"
      expect(assigns(:keywords)).to_not be_nil
    end

    it "assigns @tags" do
      get "/api/v1/lists/#{list.id}"
      expect(assigns(:tags)).to_not be_nil
    end

  end
end
