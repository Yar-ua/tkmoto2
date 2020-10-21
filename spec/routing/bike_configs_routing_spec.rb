require "rails_helper"

RSpec.describe BikeConfigsController, type: :routing do
  describe "bike configs routing" do


    it "routes to #new" do
      expect(get: "bikes/1/bike_configs/new").to route_to("bike_configs#new", bike_id: "1")
    end

    it "routes to #show" do
      expect(get: "bikes/1/bike_configs").to route_to("bike_configs#show", bike_id: "1")
    end

    # it "routes to #edit" do
    #   expect(get: "bikes/1/bike_configs/edit").to route_to("bike_configs#edit", bike_id: "1")
    # end


    it "routes to #create" do
      expect(post: "bikes/1/bike_configs").to route_to("bike_configs#create", bike_id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "bikes/1/bike_configs").to route_to("bike_configs#update", bike_id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/bikes/1/bike_configs").to route_to("bike_configs#update", bike_id: "1")
    end
  end
end
