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
    end
    
    context 'acts_as_api' do
      it 'should do something' do
        response.body.ryaml
      end
    end

    it "should retrieve status code of 200" do
      response.response_code.should == 200
    end

    it "should have JSON header" do
      response.header['Content-Type'].should include('application/json')
    end

    it "should retrieve JSON list of users" do
      response.body.should include @user1.to_json
      response.body.should include @user2.to_json
      response.body.should include @user3.to_json
    end

    xit "should limit the returned fields with fields param" do
      get :index, :format => :json, :fields => 'name'
      response.body.should     include @user1.name.to_json
      response.body.should_not include @user1.email.to_json
      response.body.should     include @user2.name.to_json
      response.body.should_not include @user2.email.to_json
    end
    
  end

  describe "#show" do
    before do
      get :show, id: @user1.id, :format => :json
    end
    
    it "should retrieve status code of 200" do
      response.response_code.should == 200
    end

    it "should have JSON header" do
      response.header['Content-Type'].should include('application/json')
    end

    it "should retrieve JSON user" do
      response.body.should include @user1.to_json
    end

    xit "should limit the returned fields with fields param" do
      get :show, id: @user1.id, :format => :json, :fields => 'name'
      response.body.should     include @user1.name.to_json
      response.body.should_not include @user1.email.to_json
    end

    xit "should always include id" do
      fields = ['name','email']
      get :show, id: @user1.id, :format => :json, :fields => fields.join(',')
      response.body.should include @user1.name.as_json(only: fields).to_json
    end
  end

end
