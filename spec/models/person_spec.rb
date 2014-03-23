require 'spec_helper'

describe Person do
  let!(:person) { FactoryGirl.build :person }
  let!(:approved_person) { FactoryGirl.build :person, approved: true }

  describe "validations" do
    it "validates presence of name" do
      expect(subject).to validate_presence_of :name
    end
  end

  describe "callbacks" do
    describe "#check_original_id" do
      context "original_id does not exist" do
        it "sets original_id" do
          person.save!
          expect(person.original_id).to eq person.id
        end
      end

      context "original_id exists" do
        it "does not set original_id" do
          person.original_id = 10
          person.save
          expect(person.original_id).to_not eq person.id
        end
      end

    end
  end

  describe ".search" do
    context "with approved person" do
      before :each do
        approved_person.save!
      end

      it "returns a collection" do
        expect(Person.search("mystring")).to be_an_instance_of ActiveRecord::Relation
      end

      it "returns a sample with instances of person" do
        expect(Person.search("mystring").sample).to be_an_instance_of Person
      end

      context "with search term in name" do
        it "returns a sample that contains the search term as name attribute" do
          search_term = "mystring"
          expect(Person.search(search_term).sample.name.downcase).to eq(search_term)
        end
      end

      context "with search term in biography" do
        it "returns a sample that contains the search term as tagline attribute" do
          search_term = "mytext"
          expect(Person.search(search_term).sample.biography.downcase).to eq(search_term)
        end
      end
    end

    context "with unapproved people" do
      it "returns a blank object" do
        person.save
        expect(Person.search("mystring")).to be_blank
      end
    end
  end

  describe ".find_popular" do
    it "returns approved people with popular > 0" do
      person.save
      approved_person.save

      expect(Person.find_popular).to include approved_person
      expect(Person.find_popular).to_not include person
    end
  end

  describe ".find_all_and_include" do
    before :each do
      approved_person.save
      person.save
    end

    it "returns a collection" do
      expect(Person.find_all_and_include(1)).to be_an_instance_of ActiveRecord::Relation
    end

    it "returns all people" do
      expect(Person.find_all_and_include(1)).to include approved_person
      expect(Person.find_all_and_include(1)).to include person
    end
  end

  describe ".find_all_approved_includes" do
    before :each do
      approved_person.save
      person.save
    end

    it "returns a collection" do
      expect(Person.find_all_approved_includes(1)).to be_an_instance_of ActiveRecord::Relation
    end

    it "includes approved people only" do
      expect(Person.find_all_approved_includes(1)).to include approved_person
      expect(Person.find_all_approved_includes(1)).to_not include person
    end
  end

  describe ".all_by_user_or_temp" do
    context "with a user_id only" do
      before :each do
        approved_person.save
        person.user_id = 2
        person.save
      end

      it "includes people with the given user_id" do
        expect(Person.all_by_user_or_temp(approved_person.user_id, "", 1)).to include approved_person
        expect(Person.all_by_user_or_temp(approved_person.user_id, "", 1)).to_not include person
      end
    end

    context "with a temp_id only" do
      before :each do
        approved_person.save
        person.temp_user_id = "test"
        person.save
      end

      it "includes people with the given temp_user_id" do
        expect(Person.all_by_user_or_temp(nil, approved_person.temp_user_id, 1)).to include approved_person
        expect(Person.all_by_user_or_temp(nil, approved_person.temp_user_id, 1)).to_not include person
      end

    end

    context "with user_id and temp_id" do
      before :each do
        approved_person.save
        person.temp_user_id = "test"
        person.save
      end

      it "includes people with the given user_id and temp_user_id" do
        expect(Person.all_by_user_or_temp(approved_person.user_id, person.temp_user_id, 1)).to include approved_person
        expect(Person.all_by_user_or_temp(approved_person.user_id, person.temp_user_id, 1)).to include person
      end

    end

    context "without user_id and temp_id" do
      before :each do
        approved_person.save
        person.save
      end

      it "does not include any person" do
        expect(Person.all_by_user_or_temp(nil, "", 1)).to_not include approved_person
        expect(Person.all_by_user_or_temp(nil, "", 1)).to_not include person
      end
    end

  end

  describe ".all_by_temp" do
    context "with temp_id" do
      before :each do
        approved_person.save
        person.temp_user_id = "test"
        person.save
      end

      it "includes people with the given temp_user_id" do
        expect(Person.all_by_temp(approved_person.temp_user_id, 1)).to include approved_person
        expect(Person.all_by_temp(approved_person.temp_user_id, 1)).to_not include person
      end

    end

    context "without temp_id" do
      before :each do
        approved_person.save
        person.save
      end

      it "does not include any person" do
        expect(Person.all_by_temp("",1)).to_not include approved_person
        expect(Person.all_by_temp("",1)).to_not include person
      end
    end
  end

  describe ".order_include_my_people" do
    before :each do
      approved_person.save
      person.save
    end

    it "returns all people" do
      expect(Person.order_include_my_people(1)).to include approved_person
      expect(Person.order_include_my_people(1)).to include person
    end

    it "returns an ordered collection" do
      expect(Person.order_include_my_people(1)).to eq [approved_person, person]
    end
  end

  describe ".find_and_include_by_id" do
    before :each do
      person.save
    end

    it "includes person with given id" do
      expect(Person.find_and_include_by_id(person.id)).to include person
    end
  end

  describe ".find_and_include_all_approved" do
    it "returns all approved persons" do
      approved_person.save
      person.save
      expect(Person.find_and_include_all_approved).to include approved_person
      expect(Person.find_and_include_all_approved).to_not include person
    end
  end

  describe ".my_person_by_user" do
    it "includes approved persons or persons by a given user" do
      person.save
      approved_person.save

      expect(Person.my_person_by_user(approved_person.user_id)).to include approved_person
      expect(Person.my_person_by_user(person.user_id)).to include person
    end
  end

  describe ".my_person_by_temp" do
    it "includes approved persons or persons by a given temp_id" do
      person.save
      approved_person.save

      expect(Person.my_person_by_temp(approved_person.temp_user_id)).to include approved_person
      expect(Person.my_person_by_temp(person.temp_user_id)).to include person
    end
  end

end
