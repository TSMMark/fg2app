require File.dirname(__FILE__) + '/../spec_helper'

describe TabsController do
  render_views

  xit "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  xit "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  xit "create action should render new template when model is invalid" do
    Tab.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  xit "create action should redirect when model is valid" do
    Tab.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(tabs_url)
  end
end
