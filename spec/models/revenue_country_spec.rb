require 'spec_helper'

describe RevenueCountry do
  let!(:revenue_country) { FactoryGirl.build :revenue_country }

  describe "validations" do
    it "validates presence of country_id" do
      expect(subject).to validate_presence_of :country_id
    end

    it "validates presence of revenue" do
      expect(subject).to validate_presence_of :revenue
    end

    it "validates presence of movie_id" do
      expect(subject).to validate_presence_of :movie_id
    end

    it "validates uniqueness of country_id with movie_id" do
      expect(subject).to validate_uniqueness_of(:country_id).scoped_to(:movie_id)
    end
  end
end
