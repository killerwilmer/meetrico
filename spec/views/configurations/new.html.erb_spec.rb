require 'spec_helper'

describe "configurations/new.html.erb" do
  before(:each) do
    assign(:configuration, stub_model(Configuration,
      :feature => "MyString",
      :value => "MyString",
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new configuration form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => configurations_path, :method => "post" do
      assert_select "input#configuration_feature", :name => "configuration[feature]"
      assert_select "input#configuration_value", :name => "configuration[value]"
      assert_select "input#configuration_description", :name => "configuration[description]"
    end
  end
end
