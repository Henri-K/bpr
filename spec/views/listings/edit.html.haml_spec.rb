require 'rails_helper'

RSpec.describe "listings/edit", type: :view do
  before(:each) do
    @listing = assign(:listing, Listing.create!(
      :address => "MyString",
      :beds => 1,
      :baths => 1,
      :parking => 1,
      :square_footage => 1,
      :year_built => 1,
      :asking_price => 1,
      :parking_price => 1,
      :condo_fees => 1,
      :property_tax => 1,
      :utility_cost => 1,
      :rent_amount => 1
    ))
  end

  it "renders the edit listing form" do
    render

    assert_select "form[action=?][method=?]", listing_path(@listing), "post" do

      assert_select "input#listing_address[name=?]", "listing[address]"

      assert_select "input#listing_beds[name=?]", "listing[beds]"

      assert_select "input#listing_baths[name=?]", "listing[baths]"

      assert_select "input#listing_parking[name=?]", "listing[parking]"

      assert_select "input#listing_square_footage[name=?]", "listing[square_footage]"

      assert_select "input#listing_year_built[name=?]", "listing[year_built]"

      assert_select "input#listing_asking_price[name=?]", "listing[asking_price]"

      assert_select "input#listing_parking_price[name=?]", "listing[parking_price]"

      assert_select "input#listing_condo_fees[name=?]", "listing[condo_fees]"

      assert_select "input#listing_property_tax[name=?]", "listing[property_tax]"

      assert_select "input#listing_utility_cost[name=?]", "listing[utility_cost]"

      assert_select "input#listing_rent_amount[name=?]", "listing[rent_amount]"
    end
  end
end
