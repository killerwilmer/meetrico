require 'spec_helper'

describe "coworking_spaces/new.html.erb" do
  before(:each) do
    assign(:coworking_space, stub_model(CoworkingSpace,
      :name => "MyString",
      :green => 1,
      :yellow => 1,
      :red => 1
    ).as_new_record)
  end

  it "renders new coworking_space form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => coworking_spaces_path, :method => "post" do
      assert_select "input#coworking_space_name", :name => "coworking_space[name]"
      assert_select "input#coworking_space_green", :name => "coworking_space[green]"
      assert_select "input#coworking_space_yellow", :name => "coworking_space[yellow]"
      assert_select "input#coworking_space_red", :name => "coworking_space[red]"
    end
  end
end
