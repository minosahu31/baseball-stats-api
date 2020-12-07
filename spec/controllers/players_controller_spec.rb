require "rails_helper"
require "spec_helper"
require "json"
RSpec.describe PlayersController, type: :controller do
  let(:json) { JSON.parse(response.body) }

  describe "Should not Get" do
    it " All Players" do
      get "index"
      expect(json["success"]).to be(true)
      expect(json["players"]).to eq([])
    end
  end

  describe "Should get players" do
    it "All Players" do
      get "index", params: { page: "1" }
      expect(json["success"]).to be(true)
      expect(json).to include("players")
    end
  end
end
