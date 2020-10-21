require 'rails_helper'

RSpec.describe BikeConfigsController, type: :controller do

  it 'expect error 404 if bike if you try to get bike configs but it is not created' do
    get :show, params: {bike_id: 1}, :format => :json
    expect(response.status).to eq(404)
  end

  describe 'access to bike_configs pathes' do

    before do
      @user = FactoryBot.create(:user)
      @bike = FactoryBot.create(:bike, user: @user)
    end
  
    it 'access to :index and :show path - permitted for unregistred users' do
      get :show, params: {bike_id: @bike.id}, :format => :json
      expect(response.status).to eq(200)
      expect(response.content_type).to include("application/json")
    end

    it 'bike configs :create and :update are forbidden for unregistred users' do
      post :create, params: {bike_id: @bike.id}, :format => :json
      expect(response.status).to eq(401)
      put :update, params: {bike_id: @bike.id, id: 1}, :format => :json
      expect(response.status).to eq(401)
    end


    describe "testing :show and :create bike configs" do
      before do
        @another_user = FactoryBot.create(:user)
        @another_bike = FactoryBot.create(:bike, user: @another_user)
        @bike_config = FactoryBot.attributes_for(:bike_config, bike: @bike)
        request.headers.merge! @user.create_new_auth_token
      end
      
      it ':show have code 404 if bike not exists' do
        get :show, params: {bike_id: 99999}, format: :json
        expect(response.status).to eq(404)
        expect( JSON.parse(response.body)["errors"] ).to eq('Bike not found')
      end
      
      it ':show available for all users if exists' do
        get :show, params: {bike_id: @another_bike.id}, format: :json
        expect(response.status).to eq(200)
        expect(response.content_type).to include("application/json")
      end

      it ":create is forbidden if current user is not bike owner" do
        post :create, params: {bike_id: @another_bike.id, bike_config: @bike_config}, :format => :json
        expect(response.status).to eq(422)
        expect( JSON.parse(response.body)["errors"] ).to eq('You have not credentials')
      end

      it 'error 404 if bike not found by ID' do
        post :create, params: { bike_id: 999999, bike_config: @bike_config }, :format => :json
        expect(response.status).to eq(404)
        expect( JSON.parse(response.body)["errors"] ).to eq('Bike not found')
      end

      it "can\'t be created with incorrect values" do
        @new_config = @bike_config
        @new_config[:oil_change] = 'azaza_21'
        post :create, params: {bike_id: @bike.id, bike_config: @new_config}, :format => :json
        expect(response.status).to eq(422)
        expect(@bike.fuels.count).to eq(0)
      end

      it "can be created with correct parameters" do
        post :create, params: {bike_id: @bike.id, bike_config: @bike_config}, :format => :json
        expect(response.status).to eq(200)
        expect(response.content_type).to include("application/json")
      end
    end
    
    
    describe 'test :update route' do
      before do
        @new_config = FactoryBot.attributes_for(:bike_config, bike: @bike)
        request.headers.merge! @user.create_new_auth_token
      end

      it 'forbidden if bike or fuel not found' do
        put :update, params: {bike_id: 99999, bike_config: @new_config}, :format => :json
        expect(response.status).to eq(404)
        expect( JSON.parse(response.body)["errors"] ).to eq('Bike not found')
      end

      it 'forbidden if you are not bike owner' do
        @another_user = FactoryBot.create(:user)
        request.headers.merge! @another_user.create_new_auth_token
        put :update, params: {bike_id: @bike.id, bike_config: @new_config}, :format => :json
        expect(response.status).to eq(422)
        expect( JSON.parse(response.body)["errors"] ).to eq('You have not credentials')
      end

      it 'successfully updated with right parameters' do
        @new_config = FactoryBot.create(:bike_config, bike: @bike)
        @upd_config = FactoryBot.attributes_for(:bike_config, bike: @bike)
        put :update, params: {bike_id: @bike.id, bike_config: @upd_config}, :format => :json
        expect(response.status).to eq(200)
        expect(response.content_type).to include("application/json")
      end
    end

  end
end
