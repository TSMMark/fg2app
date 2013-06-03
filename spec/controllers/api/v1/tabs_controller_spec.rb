require File.dirname(__FILE__) + '/../../../spec_helper'

describe Api::V1::TabsController do
  render_views

  before do
    @tab  = FactoryGirl.create(:tab)
    @page = @tab.page
    @user = @page.users.where(guest: false).first
    sign_in @user

    # TODO: new contexts for :admin, :guest, :owner, :nonowner
    # @user_not_owner = FactoryGirl.create :user_default
    # sign_in @user_not_owner
  end

  describe "#index" do
    before do
      get :index, format: :json
      @api_result = JSON::parse(response.body)
      @api_result = @api_result.insensitive if @api_result.is_a? Hash
    end
    
    it "should retrieve status code of 200" do
      response.response_code.should == 200
    end

    xit "should raise yaml result" do
      @api_result.ryaml
    end

    it "should have result" do
      @api_result.should be_has_key(:tabs)
      @api_result[:tabs].should have_at_least(1).items
    end
  end

  describe "#show" do
    before do
      get :show, id: @tab.id, format: :json
      @api_result = JSON::parse(response.body)
      @api_result = @api_result.insensitive if @api_result.is_a? Hash
    end
    
    it "should retrieve status code of 200" do
      response.response_code.should == 200
    end

    it "should raise yaml result" do
      @api_result.ryaml
    end

    it "should have result" do
      @api_result.should be_has_key(:tab)
      @api_result[:tab].should be_has_key(:id)
    end
  end

  describe "#create" do
    before do
      pending
      @user.admin = true
      @user.save!
      @tab_param  = {name: 'restful tab'}
      get :create, tab: @tab_param, format: :json
      @api_result = JSON::parse(response.body)
      @api_result = @api_result.insensitive if @api_result.is_a? Hash
    end
    
    it "should retrieve status code of 200" do
      response.response_code.should == 200
    end

    it "should have saved the name parameter" do
      @api_result.should be_has_key(:tab)
      @api_result[:tab][:name].should == @tab_param[:name]
    end

    xit "should have result" do
      @api_result.should be_has_key(:tab)
      @api_result[:tab].should be_has_key(:id)
    end
  end

end
