require 'spec_helper'

describe MovieKeyword do
  let!(:movie_keyword) { FactoryGirl.build :movie_keyword }

  describe "validations" do
    it "validates presence of keyword_id" do
      expect(subject).to validate_presence_of :keyword_id
    end

    it "validates presence of movie_id" do
      expect(subject).to validate_presence_of :movie_id
    end

    it "validates uniqueness of keyword_id with movie_id" do
      expect(subject).to validate_uniqueness_of(:keyword_id).scoped_to(:movie_id)
    end
  end
end
