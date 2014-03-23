require 'spec_helper'

describe Status do
  let!(:status) { FactoryGirl.build :status }

  describe "validations" do
    it "validates presence of status" do
      expect(subject).to validate_presence_of :status
    end
  end
end
