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
      
      xit "should raise yaml result" do
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

      xit "should raise yaml result" do
        @api_result.ryaml
      end

      it "should have result" do
        @api_result.should be_has_key(:id)
        @api_result[:id].should == @tab.id
      end
    end

    describe "#create" do
      before :each do
        sign_in @user
        @tab_param  = {:name => 'restful tab', :page_id => @page.id}
        @tab_count  = Tab.count
        get :create, :tab => @tab_param, format: :json
        parse_response response
      end
      
      xit "should raise yaml result" do
        @api_result.ryaml
      end
      
      it "should have saved the name parameter" do
        @api_result[:name].should == @tab_param[:name]
      end

      it "should have result" do
        @api_result.should be_has_key(:id)
      end

      it "increases tab count" do
        Tab.count.should == @tab_count+1
      end
    end

    describe "#update" do
      context 'when valid params' do
        before do
          @tab_param  = {name: 'updated tab'}
          get :update, id: @tab.id, tab: @tab_param, format: :json
          parse_response response
        end
        
        it "should have result" do
          @api_result.should be_has_key(:id)
        end

        it "should have saved the name parameter" do
          @api_result[:name].should == @tab_param[:name]
        end
      end

      context 'when invalid params' do
        before do
          @tab_param  = {name: 'updated tab', blargons: :jam}
          get :update, id: @tab.id, tab: @tab_param, format: :json
          parse_response response
        end
        
        it "should raise error" do
          @api_result.should be_has_key(:error)
        end

      end

      context 'when updating id' do
        before do
          @tab_param  = {id: 0}
          get :update, id: @tab.id, tab: @tab_param, format: :json
          parse_response response
        end
        
        it "should not update id" do
          @api_result.should be_has_key(:id)
          @api_result[:id].should == @tab.id
        end

      end
    end


    describe "#destroy" do

      context 'when valid id' do
        before :each do
          @delete_tab = FactoryGirl.create(:tab)
          sign_in @delete_tab.users.first
          @tab_count  = Tab.count
          get :destroy, id: @delete_tab.id, format: :json
          parse_response response
        end
        
        xit "raises yaml result" do
          @api_result.ryaml
        end
        
        it "responds with a success message" do
          @api_result.should be_has_key(:message)
        end

        it "can't find tab" do
          expect { Tab.find(@delete_tab.id) }.to raise_error
        end

        it "decreases tab count" do
          Tab.count.should == @tab_count-1
        end
      end

      context 'when invalid id' do
        before :each do
          sign_in @user
          @tab_count  = Tab.count
          get :destroy, id: Tab.last.id+99, format: :json
          parse_response response
        end
        
        it "responds with error" do
          @api_result.should be_has_key :error
        end

        it "doesn't alter tab count" do
          Tab.count.should == @tab_count
        end
      end


    end


  end





  context 'when user is not owner' do
    before do
      sign_in @not_owner
    end

    describe 'verify ownership' do
      it 'should be accurate' do
        @tab.ownerable_is_owner?(@user).should      be_true
        @tab.ownerable_is_owner?(@not_owner).should be_false
      end
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

    describe "#create" do
      before :each do
        sign_in @not_owner
        @tab_param  = {:name => 'restful tab', :page_id => @page.id}
        @tab_count  = Tab.count
        get :create, :tab => @tab_param, format: :json
        parse_response response
      end
      
      xit "should raise yaml result" do
        @api_result.ryaml
      end
      
      it "should have error" do
        @api_result.should be_has_key(:error)
      end

      it "does not increase tab count" do
        Tab.count.should == @tab_count
      end
    end


  end



end
