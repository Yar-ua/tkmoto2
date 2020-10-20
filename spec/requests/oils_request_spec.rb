 require 'rails_helper'

RSpec.describe "/oils", type: :request do

  pending "add some examples to (or delete) #{__FILE__}"
  
  # describe "GET /index" do
  #   it "renders a successful response" do
  #     Oil.create! valid_attributes
  #     get oils_url
  #     expect(response).to be_successful
  #   end
  # end

  # describe "GET /show" do
  #   it "renders a successful response" do
  #     oil = Oil.create! valid_attributes
  #     get oil_url(oil)
  #     expect(response).to be_successful
  #   end
  # end

  # describe "GET /new" do
  #   it "renders a successful response" do
  #     get new_oil_url
  #     expect(response).to be_successful
  #   end
  # end

  # describe "GET /edit" do
  #   it "render a successful response" do
  #     oil = Oil.create! valid_attributes
  #     get edit_oil_url(oil)
  #     expect(response).to be_successful
  #   end
  # end

  # describe "POST /create" do
  #   context "with valid parameters" do
  #     it "creates a new Oil" do
  #       expect {
  #         post oils_url, params: { oil: valid_attributes }
  #       }.to change(Oil, :count).by(1)
  #     end

  #     it "redirects to the created oil" do
  #       post oils_url, params: { oil: valid_attributes }
  #       expect(response).to redirect_to(oil_url(Oil.last))
  #     end
  #   end

  #   context "with invalid parameters" do
  #     it "does not create a new Oil" do
  #       expect {
  #         post oils_url, params: { oil: invalid_attributes }
  #       }.to change(Oil, :count).by(0)
  #     end

  #     it "renders a successful response (i.e. to display the 'new' template)" do
  #       post oils_url, params: { oil: invalid_attributes }
  #       expect(response).to be_successful
  #     end
  #   end
  # end

  # describe "PATCH /update" do
  #   context "with valid parameters" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }

  #     it "updates the requested oil" do
  #       oil = Oil.create! valid_attributes
  #       patch oil_url(oil), params: { oil: new_attributes }
  #       oil.reload
  #       skip("Add assertions for updated state")
  #     end

  #     it "redirects to the oil" do
  #       oil = Oil.create! valid_attributes
  #       patch oil_url(oil), params: { oil: new_attributes }
  #       oil.reload
  #       expect(response).to redirect_to(oil_url(oil))
  #     end
  #   end

  #   context "with invalid parameters" do
  #     it "renders a successful response (i.e. to display the 'edit' template)" do
  #       oil = Oil.create! valid_attributes
  #       patch oil_url(oil), params: { oil: invalid_attributes }
  #       expect(response).to be_successful
  #     end
  #   end
  # end

  # describe "DELETE /destroy" do
  #   it "destroys the requested oil" do
  #     oil = Oil.create! valid_attributes
  #     expect {
  #       delete oil_url(oil)
  #     }.to change(Oil, :count).by(-1)
  #   end

  #   it "redirects to the oils list" do
  #     oil = Oil.create! valid_attributes
  #     delete oil_url(oil)
  #     expect(response).to redirect_to(oils_url)
  #   end
  # end
end
