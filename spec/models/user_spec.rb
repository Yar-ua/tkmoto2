require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {FactoryBot.create(:user)}

  it 'user after Factory valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'user after Factory valid with valid attributes' do
    expect(user).to be_valid
  end

  describe 'oil must have all important attributes' do
    it { expect(:name).to be}
    it { expect(:email).to be}
    it { expect(:password).to be}
    it { expect(:created_at).to be}
    it { expect(:updated_at).to be}
  end    
end
