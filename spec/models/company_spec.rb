require 'spec_helper'

describe Company do
  let!(:company) { FactoryGirl.build :company }

  describe "validations" do
    it "validates presence of company" do
      expect(subject).to validate_presence_of :company
    end

    it "validates uniqueness of company" do
      expect(subject).to validate_uniqueness_of(:company).case_insensitive
    end
  end
end
