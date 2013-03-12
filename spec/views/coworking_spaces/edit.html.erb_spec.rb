require 'spec_helper'

describe "coworking_spaces/edit.html.erb" do
  before(:each) do
    @coworking_space = assign(:coworking_space, stub_model(CoworkingSpace,
      :name => "MyString",
      :green => 1,
      :yellow => 1,
      :red => 1
    ))
  end

  it "renders the edit coworking_space form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => coworking_space_path(@coworking_space), :method => "post" do
      assert_select "input#coworking_space_name", :name => "coworking_space[name]"
      assert_select "input#coworking_space_green", :name => "coworking_space[green]"
      assert_select "input#coworking_space_yellow", :name => "coworking_space[yellow]"
      assert_select "input#coworking_space_red", :name => "coworking_space[red]"
    end
  end
end
