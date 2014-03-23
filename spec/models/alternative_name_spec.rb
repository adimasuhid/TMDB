require 'spec_helper'

describe AlternativeName do
  let!(:alternative_name) { FactoryGirl.build :alternative_name }

  describe "validations" do
    it "validates presence of alternative_name" do
      expect(subject).to validate_presence_of :alternative_name
    end

    it "validates presence of person_id" do
      expect(subject).to validate_presence_of :person_id
    end

    it "validates uniqueness of alternative_name with person_id" do
      expect(subject).to validate_uniqueness_of(:alternative_name).scoped_to(:person_id)
    end

  end
end
