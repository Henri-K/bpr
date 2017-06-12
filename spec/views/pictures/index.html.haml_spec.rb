require 'rails_helper'

RSpec.describe "pictures/index", type: :view do
  before(:each) do
    assign(:pictures, [
      Picture.create!(
        :listing => nil,
        :url => "Url",
        :caption => "Caption"
      ),
      Picture.create!(
        :listing => nil,
        :url => "Url",
        :caption => "Caption"
      )
    ])
  end

  it "renders a list of pictures" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "Caption".to_s, :count => 2
  end
end
