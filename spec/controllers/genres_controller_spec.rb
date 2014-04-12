require 'spec_helper'

class CacheMock

end

describe GenresController do
  let!(:genre) { build :genre }

  describe "#index" do
    context "with a genres cache" do
      it "gets genres from cache" do
        expect_any_instance_of(Memcached).to receive(:get).with("genres")
        get :index
      end
    end

    context "without a genres cache" do
      before :each do
        genre.approved = true
        genre.save!
      end

      it "assigns @genre as a collection" do
        get :index
        expect(assigns(:genres)).to be_an_instance_of ActiveRecord::Relation
      end

      it "assigns @genre with an instance of Genre" do
        get :index
        expect(assigns(:genres).sample).to be_an_instance_of Genre
      end

      it "responds with a 200 status" do
        get :index
        expect(response.status).to eq 200
      end

      it "looks for movie genres for genre" do
        expect_any_instance_of(Genre).to receive(:movie_genres)
          .at_least(:once)
          .and_return(MovieGenre.scoped)

        get :index
      end
    end
  end
end
