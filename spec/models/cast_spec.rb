require 'spec_helper'

describe Cast do
  let!(:cast) { FactoryGirl.build :cast }

  describe "validations" do
    it "validates presence of character" do
      expect(subject).to validate_presence_of :character
    end

    it "validates presence of person_id" do
      expect(subject).to validate_presence_of :movie_id
    end

    it "validates presence of movie_id" do
      expect(subject).to validate_presence_of :person_id
    end

    it "validates case insensitive uniqueness of character with person_id and movie_id" do
      expect(subject).to validate_uniqueness_of(:character).scoped_to([:person_id, :movie_id]).case_insensitive
    end
  end
end
