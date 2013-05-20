class TabsController < ApplicationController
  def index
    @tabs = Tab.all
  end

  def new
    @tab = Tab.new
  end

  def create
    @tab = Tab.new(params[:tab])
    if @tab.save
      redirect_to tabs_url, :notice => "Successfully created tab."
    else
      render :action => 'new'
    end
  end
end
