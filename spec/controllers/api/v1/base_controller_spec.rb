require 'spec_helper'

class CacheMock
  def classify

  end
end

describe Api::V1::BaseController do

  let!(:cache) { CacheMock.new }
  let!(:user) { build :user }

  describe "filters" do
    describe "#fix_temp_user_id" do
      context "temp_user_id is undefined" do
        it "sets temp user id to empty string" do
          controller.stub(:params).and_return({ temp_user_id: "undefined" })
          expect(controller.fix_temp_user_id).to eq("")
        end
      end

      context "temp user id is not undefined" do
        it "doesn't change" do
          controller.stub(:params).and_return({ temp_user_id: nil })
          expect(controller.fix_temp_user_id).to be_nil
        end
      end
    end

    describe "#clear_cache" do
      context "action is update, create, destroy, mark, import_all" do
        it "flushes cache" do
          actions = ["update", "create", "destroy", "mark", "import_all"]
          controller.stub(:params).and_return({ action: actions.sample })

          controller.instance_variable_set(:@cache, cache)

          expect(cache).to receive(:flush)
          controller.clear_cache
        end
      end

      context "action is not update, create, destroy, mark, import_all" do
        it "returns nil" do
          controller.stub(:params).and_return({ action: "test" })

          expect(controller.clear_cache).to be_nil
        end
      end
    end

    describe "#set_pending" do
      pending("TODO: Create Tests after Small Tests")
    end

    describe "#current_api_user" do
      context "doorkeeper_token has value" do
        before :each do
          Owner = Struct.new(:resource_owner_id)
          user.save
          user.reload

          @owner = Owner.new
          @owner.resource_owner_id = user.id
        end

        it "assigns @current_api_user" do
          controller.stub(:doorkeeper_token).and_return(@owner)
          expect(controller.current_api_user).to eq(user)
        end
      end

      context "doorkeeper_token has no value" do
        it "calls current user" do
          controller.stub(:doorkeeper_token).and_return(false)
          expect(controller).to receive(:current_user)
          controller.current_api_user
        end
      end
    end
  end

  describe "private methods" do
    describe "#is_pendable" do
      context "@controller is within available actions" do
        it "returns true" do
          actions = ["alternative_names", "casts", "crews", "person_social_apps", "tags",
          "images", "videos", "alternative_titles", "casts", "crews", "movie_genres",
          "movie_keywords", "movie_languages", "movie_metadatas", "movies", "people",
          "production_companies", "releases", "revenue_countries"]

          controller.instance_variable_set(:@controller, actions.sample)
          expect(controller.send(:is_pendable)).to be_true
        end
      end

      context "@controller is outside available actions" do
        it "returns false" do
          controller.instance_variable_set(:@controller, "test")
          expect(controller.send(:is_pendable)).to be_false
        end
      end
    end

    describe "#pending_exist" do
      before :each do
        controller.instance_variable_set(:@controller, cache)
        controller.stub(:current_api_user).and_return(User.new)
        @sample = PendingItem.new
      end

      context "pending items exist" do
        it "returns true" do
          PendingItem.stub(:where).and_return([1,2,3])
          expect(controller.send(:pending_exist, @sample, 2, @sample)).to be_true
        end
      end

      context "pending items don't exist" do
        it "returns false" do
          PendingItem.stub(:where).and_return([])
          expect(controller.send(:pending_exist, @sample, 2, @sample)).to be_false
        end
      end

    end

    describe "#add_new_pending_item" do
      before :each do
        controller.stub(:params).and_return({ test: { temp_user_id: 10 } })
        controller.instance_variable_set(:@controller, cache)

      end
      it "returns a pending item" do
        expect(controller.send(:add_new_pending_item, :test, ListItem.new)).to be_an_instance_of PendingItem
      end

      it "pending item approvable_id is not nil" do
        list_item = ListItem.create

        expect(controller.send(:add_new_pending_item, :test, list_item).approvable_id).to_not be_nil
      end

      context "with a current api user" do
        it "returns pending item with user_id" do
          user.save
          user.reload

          controller.stub(:current_api_user).and_return(user)
          expect(controller.send(:add_new_pending_item, :test, ListItem.new).user_id).to_not be_nil
        end
      end

      context "without a current api user" do
        it "returns pending item with a temp_user_id" do
          expect(controller.send(:add_new_pending_item, :test, ListItem.new).temp_user_id).to_not be_nil
        end
      end

    end

    describe "#set_controller_name"
    describe "#set_params_user_id"
    describe "#set_approved_false"
    describe "#check_if_destroy"
    describe "#check_if_update"
    describe "#validate_action"
  end

end