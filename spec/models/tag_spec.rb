require 'spec_helper'

describe Tag do
  let!(:tag) { FactoryGirl.build :tag }

  describe "validations" do
    it "validates presence of person_id" do
      expect(subject).to validate_presence_of :person_id
    end

    it "validates presence of taggable_id" do
      expect(subject).to validate_presence_of :taggable_id
    end

    it "validates presence of taggable_type" do
      expect(subject).to validate_presence_of :taggable_type
    end

    it "validates uniquness of person_id with taggable_type and taggable_id" do
      expect(subject).to validate_uniqueness_of(:person_id).scoped_to([:taggable_type, :taggable_id])
    end
  end
end
