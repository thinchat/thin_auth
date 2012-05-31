require 'spec_helper'

describe User do
  describe ".approved_email?" do
    let(:user) { User.new(email: "test@hungrymachine.com") }
    context "when it is from a white-listed domain" do
      it "returns true" do
        User.approved_email?(user.email).should == true
      end
    end

    context "when it is not from a white-listed domain" do
      it "returns false" do
        user.email = "test@test.com"
        User.approved_email?(user.email).should == false
      end
    end
  end

  describe ".find_for_open_id" do
    context "when it receives a token from a non-white-listed domain" do
      it "returns a blank user" do
        access_token = double
        access_token.should_receive(:info).and_return({email: ""})
        User.should_receive(:approved_email?).and_return(false)
        User.find_for_open_id(access_token).should be_new_record
      end
    end

    context "when it receives a token from a white-listed domain" do
      it "returns a created user object" do
        access_token = double
        access_token.should_receive(:info).and_return({"email" => "a@a.com", "name" => "a"})
        User.should_receive(:approved_email?).and_return(true)
        expect{ User.find_for_open_id(access_token) }.to change(User, :count).by(1)
      end
    end
  end
end