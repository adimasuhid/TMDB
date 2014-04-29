require 'spec_helper'

class CacheMock

end

describe Api::V1::CacheController do
  describe "#expire" do
    it "returns Cache item already deleted status" do
      post "/api/v1/cache/expire.json", key: "lala", type: "key"
      expect(JSON.parse(response.body)).to eq({ "status" => "Cache item already deleted" })
    end

    context "param type is key" do
      it "calls delete for cache" do
        expect_any_instance_of(Memcached).to receive(:delete).and_return(true)
        post "/api/v1/cache/expire.json", key: "lala", type: "key"
      end
    end

    context "param type is not key" do
      it "calls flush for cache" do
        expect_any_instance_of(Memcached).to receive(:flush).and_return(true)
        post "/api/v1/cache/expire.json", key: "lala", type: "test"
      end
    end

  end
end
