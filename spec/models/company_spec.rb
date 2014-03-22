require 'spec_helper'

describe Company do
  let!(:company) { FactoryGirl.build :company }

  describe "validations" do
    it "validates presence of company" do
      expect(subject).to validate_presence_of :company
    end

    it "validates case insensitive uniqueness of company" do
      expect(subject).to validate_uniqueness_of(:company).case_insensitive
    end
  end

  describe ".search" do
    context "with approved companies" do
      before :each do
        company.approved = true
        company.save!
      end

      it "returns a collection" do
        expect(Company.search("mystring")).to be_an_instance_of ActiveRecord::Relation
      end

      it "returns a sample with instances of Company" do
        expect(Company.search("mystring").sample).to be_an_instance_of Company
      end

      it "returns a sample that contains the search term as company attribute" do
        search_term = "mystring"
        expect(Company.search(search_term).sample.company.downcase).to eq(search_term)
      end
    end

    context "with unapproved companies" do
      it "returns a blank object" do
        company.save
        expect(Company.search("mystring")).to be_blank
      end
    end
  end
end
