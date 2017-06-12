require 'rails_helper'

RSpec.describe "listings/show", type: :view do
  before(:each) do
    @listing = assign(:listing, Listing.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/7/)
    expect(rendered).to match(/8/)
    expect(rendered).to match(/9/)
    expect(rendered).to match(/10/)
    expect(rendered).to match(/11/)
    expect(rendered).to match(/12/)
  end
end
