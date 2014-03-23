require 'spec_helper'

describe ProductionCompany do
  let!(:production_company) { FactoryGirl.build :production_company }

  describe "validations" do
    it "validates presence of company_id" do
      expect(subject).to validate_presence_of :company_id
    end

    it "validates presence of movie_id" do
      expect(subject).to validate_presence_of :movie_id
    end

    it "validates uniqueness of company_id with movie_id" do
      expect(subject).to validate_uniqueness_of(:company_id).scoped_to(:movie_id)
    end

  end
end
