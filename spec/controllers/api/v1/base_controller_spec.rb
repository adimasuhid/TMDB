require 'spec_helper'

class CacheMock
  def classify

  end

  def user_type
    "admin"
  end
end

describe Api::V1::BaseController do

  let!(:cache) { CacheMock.new }
  let!(:user) { build :user }
  let!(:crew) { build :crew }
  let!(:pending_item) { build :pending_item }

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
      context "action is create or update" do
        before :each do
          controller.stub(:params).and_return({ action: "update" })
          controller.instance_variable_set(:@controller, "test")
        end

        context "is pendable" do
          before :each do
            user.save
            controller.stub(:is_pendable).and_return(true)
            controller.stub(:current_api_user).and_return(user.reload)
          end

          it "sets last item" do
            expect_any_instance_of(String).to receive(:constantize).and_return(Movie)
            controller.set_pending
          end
        end

        context "controller has movie_id column" do
          before :each do
            user.save
            crew.save
            controller.instance_variable_set(:@controller, "crews")
            controller.stub(:params).and_return({ action: "create", crew: { movie_id: 1} })
            controller.stub(:current_api_user).and_return(user.reload)
            controller.stub(:add_new_pending_item).and_return(pending_item)
          end

          context "pending exists" do
            before :each do
              controller.stub(:pending_exist).and_return(true)
            end

            it "returns nil" do
              expect(controller.set_pending).to be_nil
            end
          end

          context "pending does not exist" do
            before :each do
              controller.stub(:pending_exist).and_return(false)
            end

            it "pending is saved" do
              expect(pending_item).to receive(:save).at_least :once
              controller.set_pending
            end
          end
        end

        context "controller has person_id column" do
          before :each do
            user.save
            crew.save
            controller.instance_variable_set(:@controller, "crews")
            controller.stub(:params).and_return({ action: "create", crew: { person_id: 1} })
            controller.stub(:current_api_user).and_return(user.reload)
            controller.stub(:add_new_pending_item).and_return(pending_item)
          end

          context "pending exists" do
            before :each do
              controller.stub(:pending_exist).and_return(true)
            end

            it "returns nil" do
              expect(controller.set_pending).to be_nil
            end
          end

          context "pending does not exist" do
            before :each do
              controller.stub(:pending_exist).and_return(false)
            end

            it "pending is saved" do
              expect(pending_item).to receive(:save).at_least :once
              controller.set_pending
            end
          end
        end

        context "controller is images and action is update" do
          before :each do
            user.save
            controller.instance_variable_set(:@controller, "images")
            controller.stub(:params).and_return({ action: "update", image: { imageable_id: 1, imageable_type: "test" } })
            controller.stub(:current_api_user).and_return(user.reload)
            controller.stub(:add_new_pending_item).and_return(pending_item)
          end

          context "pending exists" do
            before :each do
              controller.stub(:pending_exist).and_return(true)
            end

            it "returns nil" do
              expect(controller.set_pending).to be_nil
            end
          end

          context "pending does not exist" do
            before :each do
              controller.stub(:pending_exist).and_return(false)
            end

            it "pending is saved" do
              expect(pending_item).to receive(:save).at_least :once
              controller.set_pending
            end
          end
        end

        context "controller is videos" do
          before :each do
            user.save
            controller.instance_variable_set(:@controller, "videos")
            controller.stub(:params).and_return({ action: "update", video: { videable_id: 1, videable_type: "test" } })
            controller.stub(:current_api_user).and_return(user.reload)
            controller.stub(:add_new_pending_item).and_return(pending_item)
          end

          context "pending exists" do
            before :each do
              controller.stub(:pending_exist).and_return(true)
            end

            it "returns nil" do
              expect(controller.set_pending).to be_nil
            end
          end

          context "pending does not exist" do
            before :each do
              controller.stub(:pending_exist).and_return(false)
            end

            it "pending is saved" do
              expect(pending_item).to receive(:save).at_least :once
              controller.set_pending
            end
          end
        end

        context "controller is tags" do
          before :each do
            user.save
            controller.instance_variable_set(:@controller, "tags")
            controller.stub(:params).and_return({ action: "update", tag: { taggable_id: 1, taggable_type: "test" } })
            controller.stub(:current_api_user).and_return(user.reload)
            controller.stub(:add_new_pending_item).and_return(pending_item)
          end

          context "pending exists" do
            before :each do
              controller.stub(:pending_exist).and_return(true)
            end

            it "returns nil" do
              expect(controller.set_pending).to be_nil
            end
          end

          context "pending does not exist" do
            before :each do
              controller.stub(:pending_exist).and_return(false)
            end

            it "pending is saved" do
              expect(pending_item).to receive(:save).at_least :once
              controller.set_pending
            end
          end
        end

        context "controller is movies" do
          before :each do
            user.save
            controller.instance_variable_set(:@controller, "movies")
            controller.stub(:params).and_return({ action: "update"})
            controller.stub(:current_api_user).and_return(user.reload)
            controller.stub(:add_new_pending_item).and_return(pending_item)
          end

          context "pending exists" do
            before :each do
              controller.stub(:pending_exist).and_return(true)
            end

            it "returns nil" do
              expect(controller.set_pending).to be_nil
            end
          end

          context "pending does not exist" do
            before :each do
              controller.stub(:pending_exist).and_return(false)
            end

            it "pending is saved" do
              expect(pending_item).to receive(:save).at_least :once
              controller.set_pending
            end
          end
        end

        context "controller is people" do
          before :each do
            user.save
            controller.instance_variable_set(:@controller, "people")
            controller.stub(:params).and_return({ action: "update"})
            controller.stub(:current_api_user).and_return(user.reload)
            controller.stub(:add_new_pending_item).and_return(pending_item)
          end

          context "pending exists" do
            before :each do
              controller.stub(:pending_exist).and_return(true)
            end

            it "returns nil" do
              expect(controller.set_pending).to be_nil
            end
          end

          context "pending does not exist" do
            before :each do
              controller.stub(:pending_exist).and_return(false)
            end

            it "pending is saved" do
              expect(pending_item).to receive(:save).at_least :once
              controller.set_pending
            end
          end
        end
      end

      context "action is not create or update" do
        before :each do
          controller.stub(:params).and_return({ action: "update" })
          controller.instance_variable_set(:@controller, "test")
        end

        it "returns nil" do
          expect(controller.set_pending).to be_nil
        end
      end
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

    describe "#set_controller_name" do
      context "controller is approvals" do
        it "sets @attributes_names to empty array" do
          controller.stub(:params).and_return({ controller: "approvals" })
          expect(controller.send(:set_controller_name)).to be_empty
        end
      end

      context "controller isnt approvals" do
        it "sets @attributes names to be not empty" do
          controller.stub(:params).and_return({ controller: "User" })
          expect(controller.send(:set_controller_name)).to_not be_empty
        end
      end
    end

    describe "#set_params_user_id" do
      context "action is create or update" do
        before :each do
          controller.instance_variable_set(:@controller, "test")
          controller.instance_variable_set(:@attribute_names, ["temp_user_id", "user_id"])
        end

        context "temp user id is present" do
          it "returns temp user id" do
            controller.stub(:params).and_return({ action: "create", temp_user_id: 1, "test" => { user_id: nil } })
            controller.send(:set_params_user_id)
            expect(controller.params["test"][:temp_user_id]).to eq(1)
          end
        end

        context "current api user and attribute_names has user id" do
          it "returns current api user id" do
            user.save
            user.reload

            controller.stub(:params).and_return({ action: "create", temp_user_id: 1, "test" => { user_id: nil } })
            controller.stub(:current_api_user).and_return(user)
            controller.send(:set_params_user_id)
            expect(controller.params["test"][:user_id]).to eq(user.id)
          end
        end

        context "no current api user and no temp user id and no params" do
          it "returns error" do
            controller.stub(:params).and_return({ action: "create", temp_user_id: nil, "test" => { user_id: nil } })
            controller.stub(:current_api_user).and_return(nil)
            expect{
              controller.send(:set_params_user_id)
            }.to raise_error
          end
        end
      end

      context "action is not create or update" do
        it "returns nil" do
          controller.stub(:params).and_return({ action: "test" })
          expect(controller.send(:set_params_user_id)).to be_nil
        end
      end
    end

    describe "#set_approved_false" do
      context "action is create" do
        context "attribute names has approved" do
          context "with current api user as admin" do
            it "returns false" do
              controller.stub(:params).and_return({ action: "update", "test" => { approved: nil }})
              controller.instance_variable_set(:@attribute_names, ["approved"])
              controller.stub(:current_api_user).and_return(cache)
              expect(controller.send(:set_approved_false)).to be_false
            end
          end

          context "with current api user as not admin" do
            it "returns false" do
              controller.stub(:params).and_return({ action: "update", "test" => { approved: nil }})
              controller.instance_variable_set(:@attribute_names, ["approved"])
              controller.stub(:current_api_user).and_return(false)
              expect(controller.send(:set_approved_false)).to be_false
            end
          end
        end

        context "attribute names has no approved" do
          it "returns nil" do
            controller.stub(:params).and_return({ action: "update" })
            controller.instance_variable_set(:@attribute_names, ["test"])
            expect(controller.send(:set_approved_false)).to be_nil
          end
        end
      end

      context "action is not create" do
        it "returns nil" do
          controller.stub(:params).and_return({ action: "update" })
          expect(controller.send(:set_approved_false)).to be_nil
        end
      end
    end

    describe "#check_if_destroy" do
      context "action is destroy for controllers list_items, videos, images, lists, follows" do
        it "calls validate action" do
          controller_names = ["list_items", "videos", "images","lists", "follows"]
          controller.stub(:params).and_return({ action: "destroy" })
          controller.instance_variable_set(:@controller, controller_names.sample)

          expect(controller).to receive :validate_action
          controller.send(:check_if_destroy)
        end
      end

      context "action is not destroy" do
        it "returns nil" do
          controller.stub(:params).and_return({ action: "update" })

          expect(controller.send(:check_if_destroy)).to be_nil
        end
      end
    end

    describe "#check_if_update" do
      context "action is update for controllers list_items, videos, images, lists, follows" do
        it "calls validate action" do
          controller_names = ["list_items", "videos", "images","lists", "follows"]
          controller.stub(:params).and_return({ action: "update" })
          controller.instance_variable_set(:@controller, controller_names.sample)

          expect(controller).to receive :validate_action
          controller.send(:check_if_update)
        end
      end

      context "action is not update" do
        it "returns nil" do
          controller.stub(:params).and_return({ action: "update" })

          expect(controller.send(:check_if_update)).to be_nil
        end
      end

    end

    describe "#validate_action" do
      context "current api user is not admin" do
        it "calls redirect to root path" do
          expect(controller).to receive :redirect_to
          controller.send(:validate_action)
        end
      end
    end
  end

end
