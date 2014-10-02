class BandsController < ApplicationController
  before_action :login

  def new
    render :new
  end

  def create
    band = Band.new(band_params)
    if band.save
      redirect_to band_url(band.name)
    else
      flash.now[:errors] = band.errors.full_messages
      render :new
    end
  end

  def show
    @band = Band.find_by(name: params[:id])
    render :show
  end

  def destroy
    Band.find_by(name: params[:id]).destroy
    redirect_to users_url
  end

  private
  def band_params
    params.require(:band).permit(:name, :user_id)
  end
end
