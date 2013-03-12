require 'spec_helper'

describe "coworking_spaces/show.html.erb" do
  before(:each) do
    @coworking_space = assign(:coworking_space, stub_model(CoworkingSpace,
      :name => "Name",
      :green => 1,
      :yellow => 1,
      :red => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
