require 'spec_helper'

describe AlternativeTitle do
  let!(:alternative_title) { FactoryGirl.build :alternative_title }

  describe "validations" do
    it "validates presence of alternative_title" do
      expect(subject).to validate_presence_of :alternative_title
    end

    it "validates presence of language_id" do
      expect(subject).to validate_presence_of :language_id
    end

    it "validates presence of movie_id" do
      expect(subject).to validate_presence_of :movie_id
    end

    it "validates uniqueness of alternative_title with language_id, movie_id" do
      expect(subject).to validate_uniqueness_of(:alternative_title).scoped_to([:language_id, :movie_id])
    end

  end
end
