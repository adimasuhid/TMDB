require 'spec_helper'

describe Movie do
  let!(:movie) { FactoryGirl.build :movie }
  let!(:approved_movie) { FactoryGirl.build :movie, approved: true }

  describe "validations" do
    it "validates presence of title" do
      expect(subject).to validate_presence_of :title
    end
  end

  describe ".search" do
    context "with approved movies" do
      before :each do
        approved_movie.save!
      end

      it "returns a collection" do
        expect(Movie.search("mystring")).to be_an_instance_of ActiveRecord::Relation
      end

      it "returns a sample with instances of movie" do
        expect(Movie.search("mystring").sample).to be_an_instance_of Movie
      end

      context "with search term in title" do
        it "returns a sample that contains the search term as title attribute" do
          search_term = "mystring"
          expect(Movie.search(search_term).sample.title.downcase).to eq(search_term)
        end
      end

      context "with search term in tagline" do
        it "returns a sample that contains the search term as tagline attribute" do
          search_term = "mystring"
          expect(Movie.search(search_term).sample.tagline.downcase).to eq(search_term)
        end
      end

      context "with search term in overview" do
        it "returns a sample that contains the search term as overview attribute" do
          search_term = "mytext"
          expect(Movie.search(search_term).sample.overview.downcase).to eq(search_term)
        end
      end
    end

    context "with unapproved movies" do
      it "returns a blank object" do
        movie.save
        expect(Movie.search("mystring")).to be_blank
      end
    end
  end

  describe ".find_all_includes" do
    before :each do
      approved_movie.save
      movie.save
    end

    it "returns a collection" do
      #expect(Movie.find_all_includes).to be_an_instance_of Array
      pending #because of erroneous method
    end

    it "returns all movies"
  end

  describe ".find_all_approved_includes" do
    before :each do
      approved_movie.save
      movie.save
    end

    it "returns a collection" do
      expect(Movie.find_all_approved_includes(1)).to be_an_instance_of ActiveRecord::Relation
    end

    it "includes approved movies only" do
      expect(Movie.find_all_approved_includes(1)).to include approved_movie
      expect(Movie.find_all_approved_includes(1)).to_not include movie
    end
  end

  describe ".all_by_user_or_temp" do
    context "with a user_id only" do
      before :each do
        approved_movie.save
        movie.user_id = 2
        movie.save
      end

      it "includes movies with the given user_id" do
        expect(Movie.all_by_user_or_temp(approved_movie.user_id, "", 1)).to include approved_movie
        expect(Movie.all_by_user_or_temp(approved_movie.user_id, "", 1)).to_not include movie
      end
    end

    context "with a temp_id only" do
      before :each do
        approved_movie.save
        movie.temp_user_id = "test"
        movie.save
      end

      it "includes movies with the given temp_user_id" do
        expect(Movie.all_by_user_or_temp(nil, approved_movie.temp_user_id, 1)).to include approved_movie
        expect(Movie.all_by_user_or_temp(nil, approved_movie.temp_user_id, 1)).to_not include movie
      end

    end

    context "with user_id and temp_id" do
      before :each do
        approved_movie.save
        movie.temp_user_id = "test"
        movie.save
      end

      it "includes movies with the given user_id and temp_user_id" do
        expect(Movie.all_by_user_or_temp(approved_movie.user_id, movie.temp_user_id, 1)).to include approved_movie
        expect(Movie.all_by_user_or_temp(approved_movie.user_id, movie.temp_user_id, 1)).to include movie
      end

    end

    context "without user_id and temp_id" do
      before :each do
        approved_movie.save
        movie.save
      end

      it "does not include any movie" do
        expect(Movie.all_by_user_or_temp(nil, "", 1)).to_not include approved_movie
        expect(Movie.all_by_user_or_temp(nil, "", 1)).to_not include movie
      end
    end

  end

  describe ".all_by_temp" do
    context "with temp_id" do
      before :each do
        approved_movie.save
        movie.temp_user_id = "test"
        movie.save
      end

      it "includes movies with the given temp_user_id" do
        expect(Movie.all_by_temp(approved_movie.temp_user_id, 1)).to include approved_movie
        expect(Movie.all_by_temp(approved_movie.temp_user_id, 1)).to_not include movie
      end

    end

    context "without temp_id" do
      before :each do
        approved_movie.save
        movie.save
      end

      it "does not include any movie" do
        expect(Movie.all_by_temp("",1)).to_not include approved_movie
        expect(Movie.all_by_temp("",1)).to_not include movie
      end
    end
  end

  describe ".order_include_my_movies" do
    before :each do
      approved_movie.save
      movie.save
    end

    it "returns all movies" do
      expect(Movie.order_include_my_movies(1)).to include approved_movie
      expect(Movie.order_include_my_movies(1)).to include movie
    end

    it "returns an ordered collection" do
      expect(Movie.order_include_my_movies(1)).to eq [approved_movie, movie]
    end
  end

  describe ".find_and_include_by_id" do
    before :each do
      movie.save
    end

    it "includes movie with given id" do
      expect(Movie.find_and_include_by_id(movie.id)).to include movie
    end
  end

  describe ".find_and_include_all_approved" do
    it "returns all approved movies" do
      approved_movie.save
      movie.save
      expect(Movie.find_and_include_all_approved).to include approved_movie
      expect(Movie.find_and_include_all_approved).to_not include movie
    end
  end

  describe ".my_movie_by_user" do
    it "includes approved movies or movies by a given user" do
      movie.save
      approved_movie.save

      expect(Movie.my_movie_by_user(approved_movie.user_id)).to include approved_movie
      expect(Movie.my_movie_by_user(movie.user_id)).to include movie
    end
  end

  describe ".my_movie_by_temp" do
    it "includes approved movies or movies by a given temp_id" do
      movie.save
      approved_movie.save

      expect(Movie.my_movie_by_temp(approved_movie.temp_user_id)).to include approved_movie
      expect(Movie.my_movie_by_temp(movie.temp_user_id)).to include movie
    end
  end

  describe ".find_popular" do
    it "returns approved movies with popular > 0" do
      movie.save
      approved_movie.save

      expect(Movie.find_popular).to include approved_movie
      expect(Movie.find_popular).to_not include movie
    end
  end
end
