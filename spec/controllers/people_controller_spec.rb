require 'spec_helper'

describe PeopleController do
  let!(:person) { build :person }

  describe "#index" do
    it "assigns @meta_title" do
      get :index
      expect(controller.instance_variable_get(:@meta_title)).to eq "Movie Database"
    end

    it "assigns @meta_description" do
      get :index
      expect(controller.instance_variable_get(:@meta_description)).to eq ""
    end

    it "assigns @meta_keywords" do
      get :index
      expect(controller.instance_variable_get(:@meta_keywords)).to eq ""
    end

    context "with a cache" do
      it "assigns @people" do
        expect_any_instance_of(Memcached).to receive(:get).with("static_people")
        get :index
      end

      it "responds with a 200 status" do
        get :index
        expect(response.status).to eq 200
      end

    end

    context "without a cache" do
      before :each do
        person.approved = true
        person.save
      end

      it "assigns @people" do
        get :index
        expect(controller.instance_variable_get(:@people).length).to eq 1
      end

      it "responds with a 200 status" do
        get :index
        expect(response.status).to eq 200
      end

    end
  end

  describe "#show" do
    before :each do
      person.approved = true
      person.save
    end

    context "with a cache" do
      it "gets multiple instance objects from cache" do
        expect_any_instance_of(Memcached).to receive(:get).with("static_person_#{person.id}")
        expect_any_instance_of(Memcached).to receive(:get).with("static_person_meta_title_#{person.id}")
        expect_any_instance_of(Memcached).to receive(:get).with("static_person_meta_description_#{person.id}")
        expect_any_instance_of(Memcached).to receive(:get).with("static_person_meta_keywords_#{person.id}")
        get :show, id: person
      end

      it "responds with a 200 status" do
        get :show, id: person
        expect(response.status).to eq 200
      end

    end

    context "without a cache" do
      before :each do
        person.approved = true
        person.save
        get :show, id: person
      end

      it "assigns @person" do
        expect(controller.instance_variable_get(:@person)).to eq(person)
      end

      it "assigns @meta_title" do
        expect(controller.instance_variable_get(:@meta_title)).to eq "MyString"
      end

      it "assigns @meta_description" do
        expect(controller.instance_variable_get(:@meta_description)).to eq "MyString"
      end

      it "assigns @meta_keywords" do
        expect(controller.instance_variable_get(:@meta_keywords)).to eq "MyString"
      end

      it "responds with a 200 status" do
        expect(response.status).to eq 200
      end

    end
  end

end
