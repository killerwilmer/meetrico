require "spec_helper"

describe Notification do
  describe "reservation" do
    let(:mail) { Notification.reservation }

    it "renders the headers" do
      mail.subject.should eq("Reservation")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
