require "rails_helper"

RSpec.describe OilsController, type: :routing do
  describe "home routing" do
    it "routes to #about" do
      expect(get: "/about").to route_to("home#about")
    end
  end
end
