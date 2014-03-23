require 'spec_helper'

describe Genre do
  let!(:genre) { FactoryGirl.build :genre }

  describe "validations" do
    it "validates presence of genre" do
      expect(subject).to validate_presence_of :genre
    end

    it "validates case insensitive uniqueness of genre" do
      expect(subject).to validate_uniqueness_of(:genre).case_insensitive
    end
  end
end
