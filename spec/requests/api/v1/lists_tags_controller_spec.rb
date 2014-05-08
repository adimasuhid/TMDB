require 'spec_helper'

describe Api::V1::ListTagsController do
  let!(:admin_user) { create :user }
  let!(:movie) { create :movie }
  let!(:list_tag) { create :list_tag, taggable_type: "movie", taggable_id: movie.id }

  describe "#create" do
    it "returns success status" do
      post "/api/v1/list_tags", list_tag: { temp_user_id: 2 }, tag_ids: [1,2], tag_types: [1,2]
      expect(JSON.parse(response.body)).to eq({ "status" => "success" })
    end

    it "creates a ListTag" do
      expect do
        post "/api/v1/list_tags", list_tag: { temp_user_id: "2"}, tag_ids: [1,2], tag_types: [1,2]
      end.to change(ListTag, :count).by(2)
    end
  end

  describe "#update" do
    context "user is not admin/moderator" do
      it "returns nil" do
        put "/api/v1/list_tags/#{list_tag.id}", list_tag: { temp_user_id: 2 }
        expect(response.body).to eq " "
      end
    end

    context "user is admin" do
      before :each do
        admin_user.user_type = "admin"
        admin_user.save
        allow_any_instance_of(Api::V1::ListTagsController).to receive(:current_api_user).and_return(admin_user)
      end

      context "no list tag" do
        it "returns error" do
          put "/api/v1/list_tags/#{list_tag.id}", list_tag: { temp_user_id: 2 }
          expect(JSON.parse(response.body)).to eq({ "status" => "error" })
        end
      end

      context "with list tag" do
        context "list tag is updated" do
          it "returns success" do
            put "/api/v1/list_tags/#{list_tag.id}", list_tag: {
              temp_user_id: 2,
              taggable_id: movie.id,
              taggable_type: "movie",
              listable_id: list_tag.listable_id,
              listable_type: list_tag.listable_type,
              approved: true
            }

            expect(JSON.parse(response.body)).to eq({ "status" => "success" })
          end
        end

        context "list tag is not updated" do
          it "returns error" do
            allow_any_instance_of(ListTag).to receive(:save).and_return(false)
            put "/api/v1/list_tags/#{list_tag.id}", list_tag: {
              temp_user_id: 2,
              taggable_id: movie.id,
              taggable_type: "movie",
              listable_id: list_tag.listable_id,
              listable_type: list_tag.listable_type,
              approved: true
            }

            expect(JSON.parse(response.body)).to eq({ "status" => "error" })
          end
        end
      end

    end
  end
end
