require File.dirname(__FILE__) + '/../../../spec_helper'

describe Api::V1::PagesController do
  render_views

  before do
    @tab  ||= FactoryGirl.create(:tab)
    @page ||= @tab.page
    @user ||= @page.users.first
    sign_in @user
  end

  describe "#index" do
    before do
      get :index, format: :json
      @api_result = JSON::parse(response.body)
      @api_result = @api_result.insensitive if @api_result.is_a? Hash
    end
    
    xit "should raise yaml pages" do
      @api_result.ryaml
    end

    xit "should retrieve status code of 200" do
      response.response_code.should == 200
    end

    xit "should have pages result" do
      @api_result.should be_has_key(:pages)
      @api_result[:pages].should have_at_least(1).items
    end
  end

end
