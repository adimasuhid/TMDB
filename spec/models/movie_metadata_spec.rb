require 'spec_helper'

describe MovieMetadata do
  let!(:movie_metadatum) { FactoryGirl.build :movie_metadatum }

  describe "validations" do
    it "validates presence of status_id" do
      expect(subject).to validate_presence_of :status_id
    end

    it "validates homepage as url" do
      expect(subject).to allow_value('http://foo.com', 'http://bar.com').for(:homepage)
      expect(subject).to_not allow_value('lalalala').for(:homepage)
    end

    it "allows homepage as blank value" do
      expect(subject).to allow_value("").for(:homepage)
    end
  end
end
