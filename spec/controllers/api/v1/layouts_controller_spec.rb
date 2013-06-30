require File.dirname(__FILE__) + '/../../../spec_helper'

describe Api::V1::LayoutsController do
  render_views

  before do
    @layout           ||= FactoryGirl.create :layout_default
    @layout_not_owned ||= FactoryGirl.create :layout_default

    @owner            ||= @layout.users.first
    @not_owner        ||= FactoryGirl.create :user_default
  end

  describe 'Owner' do
    before do
      sign_in @owner
    end

    describe "#index" do
      before do
        get :index, format: :json
        parse_response response
      end
      
      it "has results" do
        @api_result.should have_at_least(1).items
      end
      
      it "only shows owner's" do
        @api_result.each do |t|
          t = t.insensitive
          Layout.find(t[:id]).users.should be_include(@owner)
        end
      end

    end

    describe "#show" do
      before do
        get :show, id: @layout.id, format: :json
        parse_response response
      end
      
      it "has results" do
        @api_result[:id].should == @layout.id
      end
      
    end


    describe "#create" do
      before :each do
        @param  = {:name => 'restful layout'}
        @count  = Layout.count
        get :create, :layout => @param, format: :json
        parse_response response
      end
      
      xit "raises" do
        @api_result.ryaml
      end

      it "saves the name parameter" do
        @api_result[:name].should == @param[:name]
      end

      it "has result" do
        @api_result.should be_has_key(:id)
      end

      it "creates a layout_editor for user" do
        Layout.find(@api_result[:id]).users.should be_include(@owner)
      end

      it "increases count" do
        Layout.count.should == @count+1
      end
    end

    describe "#update" do
      context 'when valid params' do
        before do
          @param  = {name: 'updated name'}
          get :update, id: @layout.id, layout: @param, format: :json
          parse_response response
        end
        
        it "has result" do
          @api_result.should be_has_key(:id)
        end

        it "saves the name parameter" do
          @api_result[:name].should == @param[:name]
        end
      end

      context 'when invalid params' do
        before do
          @param  = {name: 'updated name', blargons: 'nutter buckus'}
          get :update, id: @layout.id, layout: @param, format: :json
          parse_response response
        end
        
        it "raises error" do
          @api_result.should be_has_key(:error)
        end

      end

      context 'when updating id' do
        before do
          @param  = {id: 0}
          get :update, id: @layout.id, layout: @param, format: :json
          parse_response response
        end
        
        it "doesn't update id" do
          @api_result.should be_has_key(:id)
          @api_result[:id].should == @layout.id
        end

      end
    end


  end



end