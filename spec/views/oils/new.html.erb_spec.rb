require 'rails_helper'

RSpec.describe "oils/new", type: :view do
  before(:each) do
    assign(:oil, Oil.new(
      oil_change: 1,
      bike: nil
    ))
  end

  it "renders new oil form" do
    render

    assert_select "form[action=?][method=?]", oils_path, "post" do

      assert_select "input[name=?]", "oil[oil_change]"

      assert_select "input[name=?]", "oil[bike_id]"
    end
  end
end
