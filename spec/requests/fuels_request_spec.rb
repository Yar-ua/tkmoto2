require 'rails_helper'
 
RSpec.describe FuelsController, type: :controller do
    
  it 'expect error 404 if bike if you try to get fuels but bike is not created' do
    get :index, params: {bike_id: 1}, :format => :json
    expect(response.status).to eq(404) # 404 - cauze bike is not created, so he's response must be 'not found'
    get :show, params: {bike_id: 1, id: 10}, :format => :json
    expect(response.status).to eq(404)
  end

  describe 'access to fuel pathes' do

    before do
      @user = FactoryBot.create(:user)
      @bike = FactoryBot.create(:bike, user: @user)
    end
  
    it 'access to :index and :show path - permitted for unregistred users' do
      get :index, params: {bike_id: @bike.id}, :format => :json
      expect(response.status).to eq(200)
      get :show, params: {bike_id: @bike.id, id: 1}, :format => :json
      expect(response.status).to eq(404) # 404 - cauze bike is not created, so he's response must be 'not found'
    end

    it 'fuels :create, :update and :delete are forbidden for unregistred users' do
      post :create, params: {bike_id: @bike.id}, :format => :json
      expect(response.status).to eq(401)
      put :update, params: {bike_id: @bike.id, id: 1}, :format => :json
      expect(response.status).to eq(401)
      delete :destroy, params: {bike_id: @bike.id, id: 1}, :format => :json
      expect(response.status).to eq(401)
    end


    describe "testing :show and :create fuel" do
      before do
        @another_user = FactoryBot.create(:user)
        @another_bike = FactoryBot.create(:bike, user: @another_user)
        @fuel = FactoryBot.attributes_for(:fuel, bike: @bike)
        request.headers.merge! @user.create_new_auth_token
      end
      
      it ':show have code 404 if not exists' do
        get :show, params: {bike_id: @another_bike.id, id: 99999}, format: :json
        expect(response.status).to eq(404)
        expect( JSON.parse(response.body)["errors"] ).to eq('Fuel not found')
      end
      
      it ':show available for all users if exists' do
        @fuel = FactoryBot.create(:fuel, bike: @bike)
        get :show, params: {bike_id: @another_bike.id, id: @fuel.id}, format: :json
        expect(response.status).to eq(200)
        expect(response.content_type).to include("application/json")   
      end

      it "forbidden if current user is not bike owner" do
        post :create, params: {bike_id: @another_bike.id, fuel: @fuel}, :format => :json
        expect(response.status).to eq(422)
        expect( JSON.parse(response.body)["errors"] ).to eq('You have not credentials')
      end

      it 'error 404 if bike not found by ID' do
        post :create, params: { bike_id: 999999, fuel: @fuel }, :format => :json
        expect(response.status).to eq(404)
        expect( JSON.parse(response.body)["errors"] ).to eq('Bike not found')
      end

      it "can\'t be created with incorrect values" do
        @new_fuel = @fuel
        @new_fuel[:odo_delta] = 'a21'
        post :create, params: {bike_id: @bike.id, fuel: @new_fuel}, :format => :json
        expect(response.status).to eq(422)
        expect(@bike.fuels.count).to eq(0)
      end

      it "can be created with correct parameters" do
        post :create, params: {bike_id: @bike.id, fuel: @fuel}, :format => :json
        expect(response.status).to eq(200)
        expect(response.content_type).to include("application/json")
        expect(@bike.fuels.count).to eq(1)
      end
    end
    
    
    describe 'test :update route' do
      before do
        @new_fuel = FactoryBot.create(:fuel, bike: @bike)
        request.headers.merge! @user.create_new_auth_token
      end

      it 'forbidden if bike or fuel not found' do
        put :update, params: {bike_id: 99999, id: @new_fuel.id, fuel: @new_fuel}, :format => :json
        expect(response.status).to eq(404)
        expect( JSON.parse(response.body)["errors"] ).to eq('Bike not found')
        put :update, params: {bike_id: @bike.id, id: 888888888, fuel: @new_fuel}
        expect(response.status).to eq(404)
        expect( JSON.parse(response.body)["errors"] ).to eq('Fuel not found')
      end

      it 'forbidden if you are not bike owner' do
        @another_user = FactoryBot.create(:user)
        request.headers.merge! @another_user.create_new_auth_token
        put :update, params: {bike_id: @bike.id, id: @new_fuel.id, fuel: @new_fuel}, :format => :json
        expect(response.status).to eq(422)
        expect( JSON.parse(response.body)["errors"] ).to eq('You have not credentials')
      end

      it 'successfully updated with right parameters' do
        @fuel = FactoryBot.attributes_for(:fuel, bike: @bike)
        put :update, params: {bike_id: @bike.id, id: @new_fuel.id, fuel: @fuel}, :format => :json
        expect(response.status).to eq(200)
        expect(response.content_type).to include("application/json")
      end
    end


    describe 'test :destroy route' do
      before do
        @new_fuel = FactoryBot.create(:fuel, bike: @bike)
        request.headers.merge! @user.create_new_auth_token
      end

      it 'forbidden if you are not bike owner' do
        @another_user = FactoryBot.create(:user)
        request.headers.merge! @another_user.create_new_auth_token
        delete :destroy, params: {bike_id: @bike.id, id: @new_fuel.id}, :format => :json
        expect(response.status).to eq(422)
        expect( JSON.parse(response.body)["errors"] ).to eq('You have not credentials')
      end
      
      it 'forbidden if fuel is not found' do
        delete :destroy, params: {bike_id: @bike.id, id: 99999}, :format => :json
        expect(response.status).to eq(404)
        expect( JSON.parse(response.body)["errors"] ).to eq('Fuel not found')
      end      

      it 'fuel data can be deleted' do
        delete :destroy, params: {bike_id: @bike.id, id: @new_fuel.id}, :format => :json
        expect(response.status).to eq(200)
        expect(Fuel.exists?(@new_fuel.id)).to be false
      end
    end

  end
end
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

# RSpec.describe "/bikes requests", type: :request do
#   # Oil. As you add validations to Oil, be sure to
#   # adjust the attributes here as well.
#   let(:valid_attributes) {
#     skip("Add a hash of attributes valid for your model")
#   }

#   let(:invalid_attributes) {
#     skip("Add a hash of attributes invalid for your model")
#   }

#   describe "GET /index" do
#     it "renders a successful response" do
#       Oil.create! valid_attributes
#       get oils_url
#       expect(response).to be_successful
#     end
#   end

#   describe "GET /show" do
#     it "renders a successful response" do
#       oil = Oil.create! valid_attributes
#       get oil_url(oil)
#       expect(response).to be_successful
#     end
#   end

#   describe "GET /new" do
#     it "renders a successful response" do
#       get new_oil_url
#       expect(response).to be_successful
#     end
#   end

#   describe "GET /edit" do
#     it "render a successful response" do
#       oil = Oil.create! valid_attributes
#       get edit_oil_url(oil)
#       expect(response).to be_successful
#     end
#   end

#   describe "POST /create" do
#     context "with valid parameters" do
#       it "creates a new Oil" do
#         expect {
#           post oils_url, params: { oil: valid_attributes }
#         }.to change(Oil, :count).by(1)
#       end

#       it "redirects to the created oil" do
#         post oils_url, params: { oil: valid_attributes }
#         expect(response).to redirect_to(oil_url(Oil.last))
#       end
#     end

#     context "with invalid parameters" do
#       it "does not create a new Oil" do
#         expect {
#           post oils_url, params: { oil: invalid_attributes }
#         }.to change(Oil, :count).by(0)
#       end

#       it "renders a successful response (i.e. to display the 'new' template)" do
#         post oils_url, params: { oil: invalid_attributes }
#         expect(response).to be_successful
#       end
#     end
#   end

#   describe "PATCH /update" do
#     context "with valid parameters" do
#       let(:new_attributes) {
#         skip("Add a hash of attributes valid for your model")
#       }

#       it "updates the requested oil" do
#         oil = Oil.create! valid_attributes
#         patch oil_url(oil), params: { oil: new_attributes }
#         oil.reload
#         skip("Add assertions for updated state")
#       end

#       it "redirects to the oil" do
#         oil = Oil.create! valid_attributes
#         patch oil_url(oil), params: { oil: new_attributes }
#         oil.reload
#         expect(response).to redirect_to(oil_url(oil))
#       end
#     end

#     context "with invalid parameters" do
#       it "renders a successful response (i.e. to display the 'edit' template)" do
#         oil = Oil.create! valid_attributes
#         patch oil_url(oil), params: { oil: invalid_attributes }
#         expect(response).to be_successful
#       end
#     end
#   end

#   describe "DELETE /destroy" do
#     it "destroys the requested oil" do
#       oil = Oil.create! valid_attributes
#       expect {
#         delete oil_url(oil)
#       }.to change(Oil, :count).by(-1)
#     end

#     it "redirects to the oils list" do
#       oil = Oil.create! valid_attributes
#       delete oil_url(oil)
#       expect(response).to redirect_to(oils_url)
#     end
#   end
# end
