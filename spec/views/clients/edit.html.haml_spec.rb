require 'rails_helper'

RSpec.describe "clients/edit", type: :view do
  before(:each) do
    @client = assign(:client, Client.create!(
      :name => "MyString",
      :email => "MyString",
      :down_payment => 1,
      :down_payment_type => 1,
      :interest_rate => 1,
      :amort => 1,
      :agent => nil
    ))
  end

  it "renders the edit client form" do
    render

    assert_select "form[action=?][method=?]", client_path(@client), "post" do

      assert_select "input#client_name[name=?]", "client[name]"

      assert_select "input#client_email[name=?]", "client[email]"

      assert_select "input#client_down_payment[name=?]", "client[down_payment]"

      assert_select "input#client_down_payment_type[name=?]", "client[down_payment_type]"

      assert_select "input#client_interest_rate[name=?]", "client[interest_rate]"

      assert_select "input#client_amort[name=?]", "client[amort]"

      assert_select "input#client_agent_id[name=?]", "client[agent_id]"
    end
  end
end
