require 'rails_helper'

RSpec.describe "agents/index", type: :view do
  before(:each) do
    assign(:agents, [
      Agent.create!(
        :name => "Name",
        :avatar => "Avatar",
        :email => "Email"
      ),
      Agent.create!(
        :name => "Name",
        :avatar => "Avatar",
        :email => "Email"
      )
    ])
  end

  it "renders a list of agents" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Avatar".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
end
