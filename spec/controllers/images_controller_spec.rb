require 'spec_helper'

describe ImagesController do
  let!(:image) { build :image }

  describe "#show" do
    context "with a cache" do
      before :each do
        image.save
        image.reload
      end

      it "gets multiple instance objects from cache" do
        expect_any_instance_of(Memcached).to receive(:get).with("static_images/#{image.id}")
        expect_any_instance_of(Memcached).to receive(:get).with("static_images/#{image.id}/media_tags")
        expect_any_instance_of(Memcached).to receive(:get).with("static_images/#{image.id}/media_keywords")
        expect_any_instance_of(Memcached).to receive(:get).with("static_images/#{image.id}/movies")
        expect_any_instance_of(Memcached).to receive(:get).with("static_images/#{image.id}/people")
        expect_any_instance_of(Memcached).to receive(:get).with("static_images/#{image.id}/companies")
        expect_any_instance_of(Memcached).to receive(:get).with("static_images/#{image.id}/keywords")
        get :show, id: image
      end

      it "responds with a 200 status" do
        get :show, id: image
        expect(response.status).to eq 200
      end

    end

    context "without a cache" do
      context "with an image" do
        before :each do
          image.approved = true
          image.save
          image.reload
        end

        it "assigns @image" do
          get :show, id: image
          expect(assigns(:image)).to be_an_instance_of Image
        end

        it "assigns media tags" do
          get :show, id: image
          expect(assigns(:media_tags)).to eq(image.media_tags)
        end

        it "assigns media keywords" do
          get :show, id: image
          expect(assigns(:media_keywords)).to eq(image.media_keywords)
        end

        it "calls get_tags" do
          expect(controller).to receive(:get_tags)
          get :show, id: image
        end

        it "calls get_keywords" do
          expect(controller).to receive(:get_keywords)
          get :show, id: image
        end
      end
    end
  end

  describe "#get_keywords" do
    context "with media keywords" do
      before :each do
        @media_keyword = FactoryGirl.create :media_keyword
      end

      it "calls find_all_by_id for keyword" do
        controller.instance_variable_set(:@media_keywords, [@media_keyword])
        controller.get_keywords
        expect(controller.instance_variable_get(:@keywords)).to eq Keyword.scoped
      end
    end

    context "without media keywords" do
      it "assigns @keywords" do
        controller.get_keywords
        expect(controller.instance_variable_get(:@keywords)).to eq []
      end
    end

  end
end
