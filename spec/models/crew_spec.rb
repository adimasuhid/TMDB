require 'spec_helper'

describe Crew do
  let!(:crew) { FactoryGirl.build :crew }

  describe "validations" do
    it "validates presence of job" do
      expect(subject).to validate_presence_of :job
    end

    it "validates presence of movie_id" do
      expect(subject).to validate_presence_of :movie_id
    end

    it "validates presence of person_id" do
      expect(subject).to validate_presence_of :person_id
    end

    it "validates case insensitive uniquness of job with person_id and movie_id" do
      expect(subject).to validate_uniqueness_of(:job).scoped_to([:person_id, :movie_id]).case_insensitive
    end
  end
end
