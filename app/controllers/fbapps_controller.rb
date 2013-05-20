class FbappsController < ApplicationController
  def index
    @fbapps = Fbapp.all
  end

  def show
    @fbapp = Fbapp.find(params[:id])
  end

  def new
    @fbapp = Fbapp.new
  end

  def create
    @fbapp = Fbapp.new(params[:fbapp])
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
    if @fbapp.update_attributes(params[:fbapp])
      redirect_to @fbapp, :notice  => "Successfully updated fbapp."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @fbapp = Fbapp.find(params[:id])
    @fbapp.destroy
    redirect_to fbapps_url, :notice => "Successfully destroyed fbapp."
  end
end
