require 'spec_helper'

describe "configurations/edit.html.erb" do
  before(:each) do
    @configuration = assign(:configuration, stub_model(Configuration,
      :feature => "MyString",
      :value => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit configuration form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => configurations_path(@configuration), :method => "post" do
      assert_select "input#configuration_feature", :name => "configuration[feature]"
      assert_select "input#configuration_value", :name => "configuration[value]"
      assert_select "input#configuration_description", :name => "configuration[description]"
    end
  end
end
