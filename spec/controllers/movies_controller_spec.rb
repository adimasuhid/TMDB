require 'spec_helper'

describe MoviesController do
  let!(:movie) { build :movie }

  describe "#index" do
    it "assigns @meta_title" do
      get :index
      expect(controller.instance_variable_get(:@meta_title)).to eq "Movie Database"
    end

    it "assigns @meta_description" do
      get :index
      expect(controller.instance_variable_get(:@meta_description)).to eq ""
    end

    it "assigns @meta_keywords" do
      get :index
      expect(controller.instance_variable_get(:@meta_keywords)).to eq ""
    end

    context "with a cache" do
      it "assigns @movies" do
        expect_any_instance_of(Memcached).to receive(:get).with("static_movies")
        get :index
      end

      it "responds with a 200 status" do
        get :index
        expect(response.status).to eq 200
      end

    end

    context "without a cache" do
      before :each do
        movie.approved = true
        movie.save
        movie.original_id = movie.id
        movie.save
      end

      it "assigns @movies" do
        get :index
        expect(controller.instance_variable_get(:@movies).length).to eq 1
      end

      it "responds with a 200 status" do
        get :index
        expect(response.status).to eq 200
      end

    end
  end

  describe "#show" do
    before :each do
      movie.approved = true
      movie.save
    end

    context "with a cache" do
      it "gets multiple instance objects from cache" do
        expect_any_instance_of(Memcached).to receive(:get).with("static_movie_#{movie.id}")
        expect_any_instance_of(Memcached).to receive(:get).with("static_movie_meta_title_#{movie.id}")
        expect_any_instance_of(Memcached).to receive(:get).with("static_movie_meta_description_#{movie.id}")
        expect_any_instance_of(Memcached).to receive(:get).with("static_movie_meta_keywords_#{movie.id}")
        get :show, id: movie
      end

      it "responds with a 200 status" do
        get :show, id: movie
        expect(response.status).to eq 200
      end

    end

    context "without a cache" do
      before :each do
        movie.approved = true
        movie.save
        get :show, id: movie
      end

      it "assigns @movie" do
        expect(controller.instance_variable_get(:@movie)).to eq(movie)
      end

      it "assigns @meta_title" do
        expect(controller.instance_variable_get(:@meta_title)).to eq "MyString"
      end

      it "assigns @meta_description" do
        expect(controller.instance_variable_get(:@meta_description)).to eq "MyString"
      end

      it "assigns @meta_keywords" do
        expect(controller.instance_variable_get(:@meta_keywords)).to eq "MyString"
      end

      it "responds with a 200 status" do
        expect(response.status).to eq 200
      end

    end
  end

end
