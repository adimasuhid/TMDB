require 'spec_helper'

describe MovieLanguage do
  let!(:movie_language) { FactoryGirl.build :movie_language }

  describe "validations" do
    it "validates presence of language_id" do
      expect(subject).to validate_presence_of :language_id
    end

    it "validates presence of movie_id" do
      expect(subject).to validate_presence_of :movie_id
    end

    it "validates uniqueness of language_id with movie_id" do
      expect(subject).to validate_uniqueness_of(:language_id).scoped_to(:movie_id)
    end
  end
end
