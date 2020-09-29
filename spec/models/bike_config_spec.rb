require 'rails_helper'

RSpec.describe BikeConfig, type: :model do
#   let(:user) {FactoryBot.create(:user)}
#   let(:bike) {FactoryBot.create(:bike, :user => user)}
  let(:bike) {FactoryBot.create(:bike)}
  let(:bike_config) {FactoryBot.create(:bike_config, :bike => bike)}

  it 'bike after Factory valid with valid attributes' do
    expect(bike).to be_valid
  end

  it 'bike_config after Factory valid with valid attributes' do
    expect(bike_config).to be_valid
  end

  describe 'bike_config must have all important attributes' do
    it { expect(:oil_change).to be}
    it { expect(:bike_id).to be}
    it { expect(:created_at).to be}
    it { expect(:updated_at).to be}
  end  
end
