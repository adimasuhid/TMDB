require 'spec_helper'

describe View do
  let!(:view) { FactoryGirl.build :view }

  describe "validations" do
    it "validates presence of viewable_id" do
      expect(subject).to validate_presence_of :viewable_id
    end

    it "validates presence of viewable_type" do
      expect(subject).to validate_presence_of :viewable_type
    end

    it "validates presence of views_count" do
      expect(subject).to validate_presence_of :views_count
    end
  end
end
