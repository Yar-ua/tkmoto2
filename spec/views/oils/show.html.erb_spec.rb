require 'rails_helper'

RSpec.describe "oils/show", type: :view do
  before(:each) do
    @oil = assign(:oil, Oil.create!(
      oil_change: 2,
      bike: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
  end
end
