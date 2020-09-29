require 'rails_helper'

RSpec.describe "oils/index", type: :view do
  before(:each) do
    assign(:oils, [
      Oil.create!(
        oil_change: 2,
        bike: nil
      ),
      Oil.create!(
        oil_change: 2,
        bike: nil
      )
    ])
  end

  it "renders a list of oils" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
