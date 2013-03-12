require 'spec_helper'

describe "configurations/index.html.erb" do
  before(:each) do
    assign(:configurations, [
      stub_model(Configuration,
        :feature => "Feature",
        :value => "Value",
        :description => "Description"
      ),
      stub_model(Configuration,
        :feature => "Feature",
        :value => "Value",
        :description => "Description"
      )
    ])
  end

  it "renders a list of configurations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Feature".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Value".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
