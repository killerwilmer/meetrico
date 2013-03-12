require 'spec_helper'

describe "reservations/new.html.erb" do
  before(:each) do
    assign(:reservation, stub_model(Reservation,
      :duration => 1,
      :bio => "MyText",
      :user_id => 1
    ).as_new_record)
  end

  it "renders new reservation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reservations_path, :method => "post" do
      assert_select "input#reservation_duration", :name => "reservation[duration]"
      assert_select "textarea#reservation_bio", :name => "reservation[bio]"
      assert_select "input#reservation_user_id", :name => "reservation[user_id]"
    end
  end
end
