require 'rails_helper'

RSpec.describe "pictures/new", type: :view do
  before(:each) do
    assign(:picture, Picture.new(
      :listing => nil,
      :url => "MyString",
      :caption => "MyString"
    ))
  end

  it "renders new picture form" do
    render

    assert_select "form[action=?][method=?]", pictures_path, "post" do

      assert_select "input#picture_listing_id[name=?]", "picture[listing_id]"

      assert_select "input#picture_url[name=?]", "picture[url]"

      assert_select "input#picture_caption[name=?]", "picture[caption]"
    end
  end
end
