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


  end



end
