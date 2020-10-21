require "rails_helper"

RSpec.describe FuelsController, type: :routing do
  describe "fuels routing" do
    it "routes to #index" do
      expect(get: "bikes/1/fuels").to route_to("fuels#index", bike_id: "1")
    end

    it "routes to #new" do
      expect(get: "bikes/1/fuels/new").to route_to("fuels#new", bike_id: "1")
    end

    it "routes to #show" do
      expect(get: "bikes/1/fuels/10").to route_to("fuels#show", bike_id: "1", id: "10")
    end

    # it "routes to #edit" do
    #   expect(get: "bikes/1/fuels/5/edit").to route_to("fuels#edit", bike_id: "1", id: "5")
    # end


    it "routes to #create" do
      expect(post: "bikes/1/fuels").to route_to("fuels#create", bike_id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "bikes/1/fuels/5").to route_to("fuels#update", bike_id: "1", id: "5")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/bikes/1/fuels/5").to route_to("fuels#update", bike_id: "1", id: "5")
    end

    it "routes to #destroy" do
      expect(delete: "/bikes/1/fuels/5").to route_to("fuels#destroy", bike_id: "1", id: "5")
    end
  end
end
