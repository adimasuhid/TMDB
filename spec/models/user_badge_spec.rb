require 'spec_helper'

describe UserBadge do
  let!(:user_badge) { FactoryGirl.build :user_badge }

  describe "validations" do
    it "validates presence of badge_id" do
      expect(subject).to validate_presence_of :badge_id
    end

    it "validates presence of user_id" do
      expect(subject).to validate_presence_of :user_id
    end
  end
end
