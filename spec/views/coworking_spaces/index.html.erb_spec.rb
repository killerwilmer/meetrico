require 'spec_helper'

describe "coworking_spaces/index.html.erb" do
  before(:each) do
    assign(:coworking_spaces, [
      stub_model(CoworkingSpace,
        :name => "Name",
        :green => 1,
        :yellow => 1,
        :red => 1
      ),
      stub_model(CoworkingSpace,
        :name => "Name",
        :green => 1,
        :yellow => 1,
        :red => 1
      )
    ])
  end

  it "renders a list of coworking_spaces" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
