require 'spec_helper'

describe Api::V1::StatusesController do
  let!(:status) { create :status }

  describe "#search" do
    context "with related search term" do
      it "returns status" do
        get "/api/v1/statuses/search.json", term: "mystring"
        expect(JSON.parse(response.body)).to include({ "label" => status.status, "value" => status.status, "id" => status.id})
      end
    end

    context "with unrelated search term" do
      it "retunrs an empty array" do
        get "/api/v1/statuses/search.json", term: "lalala"
        expect(JSON.parse(response.body)).to eq []
      end
    end
  end
end
