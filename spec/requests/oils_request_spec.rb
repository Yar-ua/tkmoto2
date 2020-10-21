require 'rails_helper'
 
RSpec.describe OilsController, type: :controller do
    
  it 'expect error 404 if bike if you try to get fuels but bike or oil is not created' do
    get :index, params: {bike_id: 1}, :format => :json
    expect(response.status).to eq(404) # 404 - cauze bike is not created, so he's response must be 'not found'
    expect( JSON.parse(response.body)["errors"] ).to eq('Bike not found')
    #
    @user = FactoryBot.create(:user)
    @bike = FactoryBot.create(:bike, user: @user)
    get :show, params: {bike_id: @bike.id, id: 9999}, :format => :json
    expect(response.status).to eq(404)
    expect( JSON.parse(response.body)["errors"] ).to eq('Oil not found')
  end

  describe 'access to oils pathes' do

    before do
      @user = FactoryBot.create(:user)
      @bike = FactoryBot.create(:bike, user: @user)
    end
  
    it 'access to :index and :show path - permitted for unregistred users' do
      get :index, params: {bike_id: @bike.id}, :format => :json
      expect(response.status).to eq(200)
      expect(response.content_type).to include("application/json") 
    end

    it 'oils :create, :update and :delete are forbidden for unregistred users' do
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
        @oil = FactoryBot.attributes_for(:oil, bike: @bike)
        request.headers.merge! @user.create_new_auth_token
      end
      
      it ':show have code 404 if not exists' do
        get :show, params: {bike_id: @another_bike.id, id: 99999}, format: :json
        expect(response.status).to eq(404)
        expect( JSON.parse(response.body)["errors"] ).to eq('Oil not found')
      end
      
      it ':show available for all users if exists' do
        @oil = FactoryBot.create(:oil, bike: @bike)
        get :show, params: {bike_id: @another_bike.id, id: @oil.id}, format: :json
        expect(response.status).to eq(200)
        expect(response.content_type).to include("application/json")   
      end

      it "forbidden if current user is not bike owner" do
        post :create, params: {bike_id: @another_bike.id, oil: @oil}, :format => :json
        expect(response.status).to eq(422)
        expect( JSON.parse(response.body)["errors"] ).to eq('You have not credentials')
      end

      it 'error 404 if bike not found by ID' do
        post :create, params: { bike_id: 999999, fuel: @fuel }, :format => :json
        expect(response.status).to eq(404)
        expect( JSON.parse(response.body)["errors"] ).to eq('Bike not found')
      end

      it "can\'t be created with incorrect values" do
        @new_oil = @oil
        @new_oil[:oil_change] = 'aaabbbccc555'
        post :create, params: {bike_id: @bike.id, oil: @new_oil}, :format => :json
        expect(response.status).to eq(422)
        # expect(@bike.oils.count).to eq(0)
      end

      it "can be created with correct parameters" do
        post :create, params: {bike_id: @bike.id, oil: @oil}, :format => :json
        expect(response.status).to eq(200)
        expect(response.content_type).to include("application/json")
        expect(@bike.oils.count).to eq(1)
      end
    end
    
    
    describe 'test :update route' do
      before do
        @oil = FactoryBot.create(:oil, bike: @bike)
        request.headers.merge! @user.create_new_auth_token
      end

      it 'forbidden if bike or fuel not found' do
        put :update, params: {bike_id: 99999, id: @oil.id, oil: @oil}, :format => :json
        expect(response.status).to eq(404)
        expect( JSON.parse(response.body)["errors"] ).to eq('Bike not found')
        put :update, params: {bike_id: @bike.id, id: 888888888, oil: @oil}
        expect(response.status).to eq(404)
        expect( JSON.parse(response.body)["errors"] ).to eq('Oil not found')
      end

      it 'forbidden if you are not bike owner' do
        @another_user = FactoryBot.create(:user)
        request.headers.merge! @another_user.create_new_auth_token
        put :update, params: {bike_id: @bike.id, id: @oil.id, fuel: @oil}, :format => :json
        expect(response.status).to eq(422)
        expect( JSON.parse(response.body)["errors"] ).to eq('You have not credentials')
      end

      it 'successfully updated with right parameters' do
        @new_oil = FactoryBot.attributes_for(:oil, bike: @bike)
        put :update, params: {bike_id: @bike.id, id: @oil.id, oil: @new_oil}, :format => :json
        expect(response.status).to eq(200)
        expect(response.content_type).to include("application/json")
      end
    end


    describe 'test :destroy route' do
      before do
        @new_oil = FactoryBot.create(:oil, bike: @bike)
        request.headers.merge! @user.create_new_auth_token
      end

      it 'forbidden if you are not bike owner' do
        @another_user = FactoryBot.create(:user)
        request.headers.merge! @another_user.create_new_auth_token
        delete :destroy, params: {bike_id: @bike.id, id: @new_oil.id}, :format => :json
        expect(response.status).to eq(422)
        expect( JSON.parse(response.body)["errors"] ).to eq('You have not credentials')
      end
      
      it 'forbidden if fuel is not found' do
        delete :destroy, params: {bike_id: @bike.id, id: 99999}, :format => :json
        expect(response.status).to eq(404)
        expect( JSON.parse(response.body)["errors"] ).to eq('Oil not found')
      end      

      it 'fuel data can be deleted' do
        delete :destroy, params: {bike_id: @bike.id, id: @new_oil.id}, :format => :json
        expect(response.status).to eq(200)
        expect(Fuel.exists?(@new_oil.id)).to be false
      end
    end

  end
end
 