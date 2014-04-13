require 'spec_helper'

class CacheMock

end

describe Api::V1::BaseController do

  let!(:cache) { CacheMock.new }

  describe "filters" do
    describe "#fix_temp_user_id" do
      context "temp_user_id is undefined" do
        it "sets temp user id to empty string" do
          controller.stub!(:params).and_return({ temp_user_id: "undefined" })
          expect(controller.fix_temp_user_id).to eq("")
        end
      end

      context "temp user id is not undefined" do
        it "doesn't change" do
          controller.stub!(:params).and_return({ temp_user_id: nil })
          expect(controller.fix_temp_user_id).to be_nil
        end
      end
    end

    describe "#clear_cache" do
      context "action is update, create, destroy, mark, import_all" do
        it "flushes cache" do
          actions = ["update", "create", "destroy", "mark", "import_all"]
          controller.stub!(:params).and_return({ action: actions.sample })

          controller.instance_variable_set(:@cache, cache)

          expect(cache).to receive(:flush)
          controller.clear_cache
        end
      end

      context "action is not update, create, destroy, mark, import_all" do
        it "returns nil" do
          controller.stub!(:params).and_return({ action: "test" })

          expect(controller.clear_cache).to be_nil
        end
      end
    end

    describe "#set_pending"
    describe "#current_api_user"
  end

  describe "private methods" do
    describe "#is_pendable"
    describe "#pending_exist"
    describe "#add_new_pending_item"
    describe "#set_controller_name"
    describe "#set_params_user_id"
    describe "#set_approved_false"
    describe "#check_if_destroy"
    describe "#check_if_update"
    describe "#validate_action"
  end

end
