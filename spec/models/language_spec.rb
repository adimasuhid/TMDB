require 'spec_helper'

describe Language do
  let!(:language) { FactoryGirl.build :language }

  describe "validations" do
    it "validates presence of language" do
      expect(subject).to validate_presence_of :language
    end

    it "validates case insensitive uniqueness of language" do
      expect(subject).to validate_uniqueness_of(:language).case_insensitive
    end
  end

end
