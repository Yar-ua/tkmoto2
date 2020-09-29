require "rails_helper"

RSpec.describe RepairsController, type: :routing do
  describe "repairs routing" do
    it "routes to #index" do
      expect(get: "bikes/1/repairs").to route_to("repairs#index", bike_id: "1")
    end

    it "routes to #new" do
      expect(get: "bikes/1/repairs/new").to route_to("repairs#new", bike_id: "1")
    end

    it "routes to #show" do
      expect(get: "bikes/1/repairs/5").to route_to("repairs#show", bike_id: "1", id: "5")
    end

    it "routes to #edit" do
      expect(get: "bikes/1/repairs/5/edit").to route_to("repairs#edit", bike_id: "1", id: "5")
    end


    it "routes to #create" do
      expect(post: "bikes/1/repairs").to route_to("repairs#create", bike_id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "bikes/1/repairs/5").to route_to("repairs#update", bike_id: "1", id: "5")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/bikes/1/repairs/5").to route_to("repairs#update", bike_id: "1", id: "5")
    end

    it "routes to #destroy" do
      expect(delete: "/bikes/1/repairs/5").to route_to("repairs#destroy", bike_id: "1", id: "5")
    end
  end
end
