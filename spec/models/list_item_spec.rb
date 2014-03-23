require 'spec_helper'

describe ListItem do
  let!(:list_item) { FactoryGirl.build :list_item }

  describe "validations" do
    it "validates uniqueness of list_id with listable_type and listable_id" do
      expect(subject).to validate_uniqueness_of(:list_id).scoped_to([:listable_type,:listable_id])
    end
  end

end
