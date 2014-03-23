require 'spec_helper'

describe MovieGenre do
  let!(:movie_genre) { FactoryGirl.build :movie_genre }

  describe "validations" do
    it "validates presence of genre_id" do
      expect(subject).to validate_presence_of :genre_id
    end

    it "validates presence of movie_id" do
      expect(subject).to validate_presence_of :movie_id
    end

    it "validates uniqueness of genre_id with movie_id" do
      expect(subject).to validate_uniqueness_of(:genre_id).scoped_to(:movie_id)
    end
  end
end
