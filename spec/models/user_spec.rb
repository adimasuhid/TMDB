require 'spec_helper'

describe User do
  let!(:user) { FactoryGirl.build :user }

  describe "callbacks" do
    describe "#activate" do
      it "sets active to true" do
        user.save!
        expect(user.active).to be_true
      end
    end

    describe "#set_user_type" do
      it "sets user_type to 'user'" do
        expect{ user.save }.to change(user, :user_type).to "user"
      end
    end
  end

  describe "#active_for_authentication?" do
    context "user is active" do
      before :each do
        user.active = true
        user.save
      end

      it "returns true" do
        expect(user.active_for_authentication?).to be_true
      end
    end

    context "user is inactive" do
      before :each do
        user.save
        user.active = false
        user.save
      end

      it "returns false" do
        expect(user.active_for_authentication?).to be_false
      end
    end
  end
end
