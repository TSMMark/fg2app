require File.dirname(__FILE__) + '/../../../spec_helper'

describe Api::V1::TabsController do
  render_views

  before do
    @tab            ||= FactoryGirl.create(:tab)
    @page           ||= @tab.page
    @user           ||= @page.users.where(guest: false).first

    @not_owner      ||= FactoryGirl.create :user_default
    @admin          ||= FactoryGirl.create :admin

    @tab_of_guest   ||= FactoryGirl.create(:tab)
    @guest_page     ||= @tab.page
    @guest          ||= @page.users.first
    @guest.guest=true
    @guest.save!

    # TODO: new contexts for :admin, :guest, :owner, :nonowner
    # @user_not_owner = FactoryGirl.create :user_default
    # sign_in @user_not_owner
  end

  context 'when user is owner' do
    before do
      sign_in @user
    end

    describe "#index" do
      before do
        get :index, format: :json
        parse_response response
      end
      
      it "should raise yaml result" do
        @api_result.ryaml
      end

      it "should have result" do
        @api_result.should have_at_least(1).items
      end
    end

    describe "#show" do
      before do
        get :show, id: @tab.id, format: :json
        parse_response response
      end

      it "should raise yaml result" do
        @api_result.ryaml
      end

      it "should have result" do
        @api_result.should be_has_key(:id)
        @api_result[:id].should == @tab.id
      end
    end

    describe "#create" do
      before :each do
        @user.admin = true
        @user.save!
        sign_in @user
        @tab_param  = {:name => 'restful tab', :page_id => @page}
        get :create, :tab => @tab_param, format: :json
        parse_response response
      end
      
      it "should raise yaml result" do
        @api_result.ryaml
      end
      
      it "should have saved the name parameter" do
        @api_result[:name].should == @tab_param[:name]
      end

      it "should have result" do
        @api_result.should be_has_key(:id)
      end
    end

    describe "#update" do
      before do
        pending
        # @user.admin = true
        # @user.save!
        @tab_param  = {name: 'updated tab'}
        get :update, tab: @tab_param, format: :json
        parse_response response
      end
      
      it "should have saved the name parameter" do
        @api_result[:name].should == @tab_param[:name]
      end

      it "should have result" do
        @api_result.should be_has_key(:id)
      end
    end
  end





  context 'when user is not owner' do
    before do
      sign_in @not_owner
    end

    describe "#show" do
      before do
        get :show, id: @tab.id, format: :json
        parse_response response
      end

      xit "should raise yaml result" do
        @api_result.ryaml
      end
      
      it "should respond with code 422" do
        response.response_code.should == 422
      end
      
      it "should return access error" do
        @api_result.should be_has_key(:error)
      end

    end
  end


end
