require 'spec_helper'

describe Image do
  let!(:image) { FactoryGirl.build :image }

  describe ".search" do
    context "with approved companies" do
      before :each do
        image.approved = true
        image.save!
      end

      it "returns a collection" do
        expect(Image.search("mystring")).to be_an_instance_of ActiveRecord::Relation
      end

      it "returns a sample with instances of image" do
        expect(Image.search("mystring").sample).to be_an_instance_of Image
      end

      it "returns a sample that contains the search term as image attribute" do
        search_term = "mystring"
        expect(Image.search(search_term).sample.title.downcase).to eq(search_term)
      end
    end

    context "with unapproved companies" do
      it "returns a blank object" do
        image.save
        expect(Image.search("mystring")).to be_blank
      end
    end
  end
end
