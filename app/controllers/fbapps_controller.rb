class FbappsController < ApplicationController

  respond_to :html, :json

  def index
    @fbapps = Fbapp.all
    respond_with @fbapps
  end

  def show
    @fbapp = Fbapp.find(params[:id])
    respond_with @fbapp
  end

  def new
    @fbapp = Fbapp.new
    respond_with @fbapp
  end

  def create
    @fbapp = Fbapp.new(params[:fbapp])
    respond_with @fbapp
    return
    if @fbapp.save
      redirect_to @fbapp, :notice => "Successfully created fbapp."
    else
      render :action => 'new'
    end
  end

  def edit
    @fbapp = Fbapp.find(params[:id])
  end

  def update
    @fbapp = Fbapp.find(params[:id])
    @fbapp.update_attributes(params[:fbapp])
    respond_with @fbapp
    return
    if @fbapp
      redirect_to @fbapp, :notice  => "Successfully updated fbapp."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @fbapp = Fbapp.find(params[:id])
    @fbapp.destroy
    respond_with @fbapp
    return
    redirect_to fbapps_url, :notice => "Successfully destroyed fbapp."
  end
end
