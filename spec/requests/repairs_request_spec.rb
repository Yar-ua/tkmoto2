require 'rails_helper'
 
RSpec.describe RepairsController, type: :controller do

  describe "access to fuels pathes" do
    before do
    @user = FactoryBot.create(:user)
    @bike = FactoryBot.create(:bike, user: @user)
    end

    it "repair index permitted for all users" do
      get :index, params: {bike_id: @bike.id}, format: :json
      expect(response.status).to eq(200)
    end
    
    it "all other fuel pathes forbidden for unauthorized users" do
      post :create, params: {bike_id: @bike.id}, format: :json
      expect(response.status).to eq(401)
      put :update, params: {bike_id: @bike.id, id: 1}, format: :json
      expect(response.status).to eq(401)
      delete :destroy, params: {bike_id: @bike.id, id: 1}, format: :json
      expect(response.status).to eq(401)
    end

    describe "testing repair :index" do
      it "test repair :index page, error 404 if bike not found" do
        get :index, params: {bike_id: 999999}, format: :json
        expect(response.status).to eq(404)
        expect( JSON.parse(response.body)["errors"] ).to eq('Bike not found')
      end
      
      it "test repair :index page" do
        get :index, params: {bike_id: @bike.id}, format: :json
        expect(response.status).to eq(200)
        expect(response.content_type).to include("application/json")
      end
    end


    describe "testing :show and :create repair" do
      before do
        @another_user = FactoryBot.create(:user)
        @another_bike = FactoryBot.create(:bike, user: @another_user)
        @repair = FactoryBot.attributes_for(:repair, bike: @bike)
        request.headers.merge! @user.create_new_auth_token
      end

      it ':show have code 404 if not exists' do
        get :show, params: {bike_id: @another_bike.id, id: 99999}, format: :json
        expect(response.status).to eq(404)
        expect( JSON.parse(response.body)["errors"] ).to eq('Repair not found')
      end
      
      it ':show available for all users if exists' do
        @repair = FactoryBot.create(:repair, bike: @bike)
        get :show, params: {bike_id: @another_bike.id, id: @repair.id}, format: :json
        expect(response.status).to eq(200)
        expect(response.content_type).to include("application/json")   
      end

      it ":create forbidden if current user is not bike owner" do
        post :create, params: {bike_id: @another_bike.id, repair: @repair}, format: :json
        expect(response.status).to eq(422)
        expect( JSON.parse(response.body)["errors"] ).to eq('You have not credentials')
      end

      it ':create error 404 if bike not found by ID' do
        post :create, params: {bike_id: 999999, repair: @repair}, format: :json
        expect(response.status).to eq(404)
        expect( JSON.parse(response.body)["errors"] ).to eq('Bike not found')
      end

      it "can\'t be created with incorrect values" do
        @new_repair = @repair
        @new_repair[:price] = 'a21'
        post :create, params: {bike_id: @bike.id, repair: @new_repair}, format: :json
        expect(response.status).to eq(422)
        expect(@bike.repairs.count).to eq(0)
      end

      it "can be created with correct parameters" do
        post :create, params: {bike_id: @bike.id, repair: @repair}, format: :json
        expect(response.status).to eq(200)
        expect(response.content_type).to include("application/json")
        expect(@bike.repairs.count).to eq(1)
      end
    end


    describe 'test :update route' do
      before do
        @new_repair = FactoryBot.create(:repair, bike: @bike)
        request.headers.merge! @user.create_new_auth_token
      end

      it 'forbidden if bike or repair is not found' do
        put :update, params: {bike_id: 99999, id: @new_repair.id, repair: @new_repair}, format: :json
        expect(response.status).to eq(404)
        expect( JSON.parse(response.body)["errors"] ).to eq('Bike not found')
        put :update, params: {bike_id: @bike.id, id: 888888888, repair: @new_repair}, format: :json
        expect(response.status).to eq(404)
        expect( JSON.parse(response.body)["errors"] ).to eq('Repair not found')
      end

      it 'forbidden if you are not bike owner' do
        @another_user = FactoryBot.create(:user)
        request.headers.merge! @another_user.create_new_auth_token
        put :update, params: {bike_id: @bike.id, id: @new_repair.id, repair: @new_repair}, format: :json
        expect(response.status).to eq(422)
        expect( JSON.parse(response.body)["errors"] ).to eq('You have not credentials')
      end

      it 'successfully updated with right parameters' do
        @repair = FactoryBot.attributes_for(:repair, bike: @bike)
        put :update, params: {bike_id: @bike.id, id: @new_repair.id, repair: @repair}, format: :json
        expect(response.status).to eq(200)
        expect(response.content_type).to include("application/json")
      end
    end


    describe 'test repair :destroy route' do
      before do
        @new_repair = FactoryBot.create(:repair, bike: @bike)
        request.headers.merge! @user.create_new_auth_token
      end

      it 'forbidden if you are not bike owner' do
        @another_user = FactoryBot.create(:user)
        request.headers.merge! @another_user.create_new_auth_token
        delete :destroy, params: {bike_id: @bike.id, id: @new_repair.id}, format: :json
        expect(response.status).to eq(422)
        expect( JSON.parse(response.body)["errors"] ).to eq('You have not credentials')
      end
      
      it 'forbidden if repair is not found' do
        delete :destroy, params: {bike_id: @bike.id, id: 99999}, :format => :json
        expect(response.status).to eq(404)
        expect( JSON.parse(response.body)["errors"] ).to eq('Repair not found')
      end           

      it 'repair data can be deleted' do
        delete :destroy, params: {bike_id: @bike.id, id: @new_repair.id}, format: :json
        expect(response.status).to eq(200)
        expect(Repair.exists?(@new_repair.id)).to be false
      end
    end

  end
  
end