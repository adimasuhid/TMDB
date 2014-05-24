require 'spec_helper'

describe Api::V1::PeopleController do
  let!(:people) { create :person }
  let!(:user) { create :user }
  let!(:approved_people) { create :person, approved: true}

  describe "#index" do
    context "with cached content" do
      it "assigns people with cached content" do
        allow_any_instance_of(Memcached).to receive(:get).and_return(people)
        get "/api/v1/people.json"
        expect(assigns(:people)).to eq people
      end
    end

    context "without cached content" do
      it "assigns items count" do
        get "/api/v1/people.json"
        expect(assigns(:items_count)).to_not be_nil
      end

      it "assigns people" do
        get "/api/v1/people.json"
        expect(assigns(:people)).to_not be_nil
      end

      it "assigns all" do
        get "/api/v1/people.json"
        expect(assigns(:all)).to_not be_nil
      end

      it "assigns current api user" do
        allow_any_instance_of(Api::V1::PeopleController).to receive(:current_api_user).and_return(user)
        get "/api/v1/people.json"
        expect(assigns(:current_api_user)).to_not be_nil
      end
    end
  end

  describe "#my_people" do
    it "assigns people" do
      get "/api/v1/people/my_people.json"
      expect(assigns(:people)).to_not be_nil
    end

    it "assigns all" do
      get "/api/v1/people/my_people.json"
      expect(assigns(:all)).to_not be_nil
    end

    it "assigns current api user" do
      allow_any_instance_of(Api::V1::PeopleController).to receive(:current_api_user).and_return(user)
      get "/api/v1/people/my_people.json"
      expect(assigns(:current_api_user)).to_not be_nil
    end

    it "renders my people" do
      get "/api/v1/people/my_people.json"
      expect(response).to render_template "my_people"
    end
  end

end
