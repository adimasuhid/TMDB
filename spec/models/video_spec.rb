require 'spec_helper'

describe Video do
  let!(:video) { FactoryGirl.build :video }

  describe "validations" do
    it "validates presence of link" do
      expect(subject).to validate_presence_of :link
    end

    it "validates presence of priority" do
      expect(subject).to validate_presence_of :priority
    end

    it "validates presence of title" do
      expect(subject).to validate_presence_of :title
    end

    it "validates link as url" do
      expect(subject).to allow_value('http://foo.com', 'http://bar.com').for(:link)
      expect(subject).to_not allow_value('lalalala').for(:link)
    end

    it "validates uniqueness of link with videable_id and videable_type" do
      expect(subject).to validate_uniqueness_of(:link).scoped_to([:videable_id, :videable_type])
    end
  end

  describe ".search" do
    context "with approved videos" do
      before :each do
        video.approved = true
        video.save!
      end

      it "returns a collection" do
        expect(Video.search("mystring")).to be_an_instance_of ActiveRecord::Relation
      end

      it "returns a sample with instances of video" do
        expect(Video.search("mystring").sample).to be_an_instance_of Video
      end

      it "returns a sample that contains the search term as title attribute" do
        search_term = "mystring"
        expect(Video.search(search_term).sample.title.downcase).to eq(search_term)
      end
    end

    context "with unapproved videos" do
      it "returns a blank object" do
        video.save
        expect(Video.search("mystring")).to be_blank
      end
    end
  end
end
