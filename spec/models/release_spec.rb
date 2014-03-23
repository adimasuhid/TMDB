require 'spec_helper'

describe Release do
  let!(:release) { FactoryGirl.build :release }

  describe "validations" do
    it "validates presence of country_id" do
      expect(subject).to validate_presence_of :country_id
    end

    it "validates presence of release_date" do
      expect(subject).to validate_presence_of :release_date
    end

    it "validates presence of movie_id" do
      expect(subject).to validate_presence_of :movie_id
    end
  end
end
