require 'rails_helper'

RSpec.describe "BikeConfigs", type: :request do

  describe "GET /show" do
    it "returns http success" do
      get "/bike_configs/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/bike_configs/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/bike_configs/update"
      expect(response).to have_http_status(:success)
    end
  end

end
