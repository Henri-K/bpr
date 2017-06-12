require 'rails_helper'

RSpec.describe "listings/index", type: :view do
  before(:each) do
    assign(:listings, [
      Listing.create!(
        :address => "Address",
        :beds => 2,
        :baths => 3,
        :parking => 4,
        :square_footage => 5,
        :year_built => 6,
        :asking_price => 7,
        :parking_price => 8,
        :condo_fees => 9,
        :property_tax => 10,
        :utility_cost => 11,
        :rent_amount => 12
      ),
      Listing.create!(
        :address => "Address",
        :beds => 2,
        :baths => 3,
        :parking => 4,
        :square_footage => 5,
        :year_built => 6,
        :asking_price => 7,
        :parking_price => 8,
        :condo_fees => 9,
        :property_tax => 10,
        :utility_cost => 11,
        :rent_amount => 12
      )
    ])
  end

  it "renders a list of listings" do
    render
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
    assert_select "tr>td", :text => 9.to_s, :count => 2
    assert_select "tr>td", :text => 10.to_s, :count => 2
    assert_select "tr>td", :text => 11.to_s, :count => 2
    assert_select "tr>td", :text => 12.to_s, :count => 2
  end
end
