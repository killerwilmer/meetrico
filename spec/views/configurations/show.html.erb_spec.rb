require 'spec_helper'

describe "configurations/show.html.erb" do
  before(:each) do
    @configuration = assign(:configuration, stub_model(Configuration,
      :feature => "Feature",
      :value => "Value",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Feature/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Value/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Description/)
  end
end
