require "rails_helper"

RSpec.describe OilsController, type: :routing do
  describe "oils routing" do
    it "routes to #index" do
      expect(get: "bikes/1/oils").to route_to("oils#index", bike_id: "1")
    end

    it "routes to #new" do
      expect(get: "bikes/1/oils/new").to route_to("oils#new", bike_id: "1")
    end

    it "routes to #show" do
      expect(get: "bikes/1/oils/10").to route_to("oils#show", bike_id: "1", id: "10")
    end

    # it "routes to #edit" do
    #   expect(get: "bikes/1/oils/10/edit").to route_to("oils#edit", bike_id: "1", id: "10")
    # end


    it "routes to #create" do
      expect(post: "bikes/1/oils").to route_to("oils#create", bike_id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "bikes/1/oils/10").to route_to("oils#update", bike_id: "1", id: "10")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/bikes/1/oils/10").to route_to("oils#update", bike_id: "1", id: "10")
    end

    it "routes to #destroy" do
      expect(delete: "/bikes/1/oils/10").to route_to("oils#destroy", bike_id: "1", id: "10")
    end
  end
end
