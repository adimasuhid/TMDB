require 'spec_helper'

describe PersonSocialApp do
  let!(:person_social_app) { FactoryGirl.build :person_social_app }

  describe "validations" do
    it "validates presence of person_id" do
      expect(subject).to validate_presence_of :person_id
    end

    it "validates presence of profile_link" do
      expect(subject).to validate_presence_of :profile_link
    end

    it "validates presence of social_app_id" do
      expect(subject).to validate_presence_of :social_app_id
    end

    it "validates case insensitive uniqueness of profile_link with person_id and social_app_id" do
      expect(subject).to validate_uniqueness_of(:profile_link).scoped_to([:person_id, :social_app_id]).case_insensitive
    end
  end
end
