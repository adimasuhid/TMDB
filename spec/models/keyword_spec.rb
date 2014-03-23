require 'spec_helper'

describe Keyword do
  let!(:keyword) { FactoryGirl.build :keyword }

  describe "validations" do
    it "validates presence of keyword" do
      expect(subject).to validate_presence_of :keyword
    end

    it "validates case insensitive uniqueness of keyword" do
      expect(subject).to validate_uniqueness_of(:keyword).case_insensitive
    end
  end

end
