require 'spec_helper'
require 'rack/test'

describe "service" do
  describe "GET on /api/v1/users/:id" do
    let(:user) { User.create(:name => "a", :email => "a@a.com", :password => "hungry") }

    it "should return a user by name" do
      get ('/api/v1/users/' + user.id.to_s)
      response.status.should == 200
      attributes = JSON.parse(response.body)
      attributes["name"].should == "a"
    end

    it "should return a user with an email" do
      get ('/api/v1/users/' + user.id.to_s)
      response.status.should == 200
      attributes = JSON.parse(response.body)
      attributes["email"].should == "a@a.com"
    end

    it "should return a 404 for a user that doesn't exist" do
      get '/api/v1/users/100'
      response.status.should == 404
    end
  end
end