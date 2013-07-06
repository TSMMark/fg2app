require File.dirname(__FILE__) + '/../../../spec_helper'

describe Api::V1::UsersController do
  render_views

  before do
    @user1 = FactoryGirl.create(:user_default)
    @user2 = FactoryGirl.create(:user_default)
    @user3 = FactoryGirl.create(:user_default)
    sign_in @user1
  end

  describe "#index" do
    before do
      get :index, format: :json
      @api_result = JSON::parse(response.body)
      @api_result = @api_result.insensitive if @api_result.is_a? Hash
    end
    
    xit "should raise yaml result" do
      @api_result.ryaml
    end

    xit "should have users result" do
      @api_result.should be_has_key(:users)
      @api_result[:users].should have_at_least(1).items
    end

    xit "should retrieve status code of 200" do
      response.response_code.should == 200
    end

    xit "should have JSON header" do
      response.header['Content-Type'].should include('application/json')
    end

  end

  describe "#show" do
    before do
      get :show, id: @user1.id, :format => :json
    end
    
    xit "should retrieve status code of 200" do
      response.response_code.should == 200
    end

    xit "should have JSON header" do
      response.header['Content-Type'].should include('application/json')
    end

  end

end
