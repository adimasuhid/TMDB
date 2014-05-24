require 'spec_helper'

describe Api::V1::ListKeywordsController do
  let!(:keyword) { create :keyword }
  let!(:list_keyword) { create :list_keyword, keyword_id: keyword.id }
  let!(:user) { create :user, user_type: "admin" }

  describe "#create" do
    it "creates list keyword" do
      expect do
        post "/api/v1/list_keywords", { list_keyword: { temp_user_id: user.id }, keyword_ids: [keyword.id] }
      end.to change(ListKeyword, :count).by 1
    end

    it "returns success" do
      post "/api/v1/list_keywords", { list_keyword: { temp_user_id: user.id }, keyword_ids: [keyword.id] }
      expect(JSON.parse response.body).to eq({ "status" => "success" })
    end
  end

  describe "#destroy" do
    context "successful destroy" do
      it "reduces list keyword" do
        expect do
          delete "/api/v1/list_keywords/#{list_keyword.id}",
            {
              list_keyword: { temp_user_id: user.id },
              listable_id: list_keyword.listable_id,
              listable_type: list_keyword.listable_type,
              keyword_id: list_keyword.keyword_id,
              temp_user_id: list_keyword.temp_user_id
            }
        end.to change(ListKeyword, :count).by(-1)
      end

      it "returns success" do
        delete "/api/v1/list_keywords/#{list_keyword.id}",
          {
            list_keyword: { temp_user_id: user.id },
            listable_id: list_keyword.listable_id,
            listable_type: list_keyword.listable_type,
            keyword_id: list_keyword.keyword_id,
            temp_user_id: list_keyword.temp_user_id
          }

          expect(JSON.parse response.body).to eq({ "status" => "success" })
      end
    end

    context "unsuccessful destroy" do
      it "returns error" do
        allow_any_instance_of(ActiveRecord::Relation).to receive(:destroy_all).and_return(false)
        delete "/api/v1/list_keywords/#{list_keyword.id}",
          {
            list_keyword: { temp_user_id: user.id },
            listable_id: list_keyword.listable_id,
            listable_type: list_keyword.listable_type,
            keyword_id: list_keyword.keyword_id,
            temp_user_id: list_keyword.temp_user_id
          }

          expect(JSON.parse response.body).to eq({ "status" => "error" })
      end
    end
  end

  describe "#update" do
    context "current api user is an admin" do
      before :each do
        user.update_attributes(user_type: "admin")
        allow_any_instance_of(Api::V1::ListKeywordsController).to receive(:current_api_user).and_return(user)
      end

      context "no list keywords" do
        it "returns an error" do
          put "/api/v1/list_keywords/#{list_keyword.id}",
            {
              list_keyword: { temp_user_id: user.id },
              listable_id: list_keyword.listable_id,
              listable_type: list_keyword.listable_type,
              keyword_id: list_keyword.keyword_id,
              temp_user_id: list_keyword.temp_user_id
            }

          expect(JSON.parse response.body).to eq({ "status" => "error" })
        end
      end

      context "with list keywords" do
        context "with successful save" do
          it "returns success" do
            put "/api/v1/list_keywords/#{list_keyword.id}",
              {
                list_keyword: {
                  temp_user_id: user.id,
                  listable_id: list_keyword.listable_id,
                  listable_type: list_keyword.listable_type,
                  keyword_id: list_keyword.keyword_id,
                }
              }

            expect(JSON.parse response.body).to eq({ "status" => "success" })
          end
        end

        context "with erroneous save" do
          it "returns error" do
            allow_any_instance_of(ListKeyword).to receive(:save).and_return(false)
            put "/api/v1/list_keywords/#{list_keyword.id}",
              {
                list_keyword: {
                  temp_user_id: user.id,
                  listable_id: list_keyword.listable_id,
                  listable_type: list_keyword.listable_type,
                  keyword_id: list_keyword.keyword_id,
                }
              }

            expect(JSON.parse response.body).to eq({ "status" => "error" })
          end
        end
      end
    end

  end
end
