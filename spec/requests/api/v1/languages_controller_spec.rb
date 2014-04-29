require 'spec_helper'

describe Api::V1::LanguagesController do
  let!(:language) { create :language }

  describe "#search" do
    it "returns hash of label, value and id" do
      get "/api/v1/languages/search.json", term: "string"
      expect(JSON.parse(response.body)).to include({ "label" => language.language, "value" => language.language, "id" => language.id })
    end
  end

end
