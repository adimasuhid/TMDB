require 'spec_helper'

describe Api::V1::KeywordsController do
  let!(:keyword) { create :keyword }

  describe "#search" do
    it "returns hash of label, value and id" do
      get "/api/v1/keywords/search.json", term: "string"
      expect(JSON.parse(response.body)).to include({ "label" => keyword.keyword, "value" => keyword.keyword, "id" => keyword.id })
    end
  end

end
