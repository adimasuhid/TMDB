require 'spec_helper'

describe SocialApp do
  let!(:social_app) { FactoryGirl.build :social_app }

  describe "validations" do
    it "validates presence of social_app" do
      expect(subject).to validate_presence_of :social_app
    end

    it "validates case insensitive uniqueness of social_app" do
      expect(subject).to validate_uniqueness_of(:social_app).case_insensitive
    end
  end
end
