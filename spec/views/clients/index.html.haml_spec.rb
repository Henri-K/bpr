require 'rails_helper'

RSpec.describe "clients/index", type: :view do
  before(:each) do
    assign(:clients, [
      Client.create!(
        :name => "Name",
        :email => "Email",
        :down_payment => 2,
        :down_payment_type => 3,
        :interest_rate => 4,
        :amort => 5,
        :agent => nil
      ),
      Client.create!(
        :name => "Name",
        :email => "Email",
        :down_payment => 2,
        :down_payment_type => 3,
        :interest_rate => 4,
        :amort => 5,
        :agent => nil
      )
    ])
  end

  it "renders a list of clients" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
