 require 'rails_helper'
 
 RSpec.describe BikesController, type: :controller do

  it 'index and show - permitted for unregistred users' do
    get :index
    expect(response.status).to eq(200)
    get :show, params: {id: 1}
    expect(response.status).to eq(404) # 404 - cauze bike is not created, so he's response must be 'not found'
  end

  it 'forbidden for unregistred users' do
    post :create
    expect(response.status).to eq(401)
    put :update, params: {id: 1}
    expect(response.status).to eq(401)
    delete :destroy, params: {id: 1}
    expect(response.status).to eq(401)
  end

  describe 'when user authenticated' do
    describe 'testing Create, Read' do
      before do
        @user = FactoryBot.create(:user)
        @bike = FactoryBot.attributes_for(:bike, user: @user)
        request.headers.merge! @user.create_new_auth_token
      end

      it 'get index page' do
        get :index
        expect(response.status).to eq(200)
      end
      
      it 'create bike' do
        post :create, params: {bike: @bike}
        expect(response.status).to eq(200)
        expect(@user.bikes.count).to be > 0
      end
    end

    describe 'testing Show Update Delete' do
      before do
        @user = FactoryBot.create(:user)
        @another_user = FactoryBot.create(:user)
        @bike = FactoryBot.create(:bike, user: @user)
        request.headers.merge! @user.create_new_auth_token
      end

      it 'show bike' do
        get :show, params: {id: @bike.id}
        expect(response.status).to eq(200)
        expect(response.body).to include(@bike.to_json)
      end

      it 'update bike forbidden if user is not bike owner' do
        request.headers.merge! @another_user.create_new_auth_token
        @new_name = 'Yamaha KLX'
        put :update, params: { id: @bike.id, bike: {name: @new_name} }
        expect(response.status).to eq(422)
      end

      it 'update bike' do
        @new_name = 'Yamaha KLX'
        put :update, params: { id: @bike.id, bike: {name: @new_name} }
        expect(response.status).to eq(200)
        expect(Bike.find(@bike.id)[:name]).to eq(@new_name)
      end

      it 'destroy bike forbidden if user is not bike owner' do
        request.headers.merge! @another_user.create_new_auth_token
        delete :destroy, params: {id: @bike.id}
        expect(response.status).to eq(422)
        expect(Bike.exists?(@bike.id)).to be true
      end

      it 'destroy bike' do
        delete :destroy, params: {id: @bike.id}
        expect(response.status).to eq(200)
        expect(Bike.exists?(@bike.id)).to be false
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
