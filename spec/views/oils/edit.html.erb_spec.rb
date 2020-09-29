require 'rails_helper'

RSpec.describe "oils/edit", type: :view do
  before(:each) do
    @oil = assign(:oil, Oil.create!(
      oil_change: 1,
      bike: nil
    ))
  end

  it "renders the edit oil form" do
    render

    assert_select "form[action=?][method=?]", oil_path(@oil), "post" do

      assert_select "input[name=?]", "oil[oil_change]"

      assert_select "input[name=?]", "oil[bike_id]"
    end
  end
end
