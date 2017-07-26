require 'rails_helper'

RSpec.describe "agents/show", type: :view do
  before(:each) do
    @agent = assign(:agent, Agent.create!(
      :name => "Name",
      :avatar => "Avatar",
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Avatar/)
    expect(rendered).to match(/Email/)
  end
end
