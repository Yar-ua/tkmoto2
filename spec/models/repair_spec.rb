require 'rails_helper'

RSpec.describe Repair, type: :model do
  let(:user) {FactoryBot.create(:user)}
  let(:bike) {FactoryBot.create(:bike, :user => user)}
  let(:repair) {FactoryBot.create(:repair, :bike => bike)}

  it 'bike after Factory valid with valid attributes' do
    expect(bike).to be_valid
    expect(bike.user).to be_valid
  end

  it 'oil after Factory valid with valid attributes' do
    expect(repair).to be_valid
  end

  describe 'oil must have all important attributes' do
    it { expect(:description).to be}
    it { expect(:note).to be}
    it { expect(:price).to be}
    it { expect(:date).to be}
    it { expect(:bike_id).to be}
    it { expect(:created_at).to be}
    it { expect(:updated_at).to be}
  end    
end
