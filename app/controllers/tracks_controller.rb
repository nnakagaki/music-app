class TracksController < ApplicationController
  before_action :login, :band_update, :album_update

  def new
    render :new
  end

  def create
    track = Track.new(track_params)
    if track.save
      redirect_to band_album_track_url(band_id: params[:band],
                                       album_id: params[:album],
                                       id: track.name)
    else
      flash.now[:errors] = track.errors.full_messages
      render :new
    end
  end

  def show
    @track = Track.find_by(name: params[:id], album_id: cookies[:album_id])
    render :show
  end

  private
  def track_params
    track_params = params.require(:track).permit(:name, :lyrics, :track_type)
    track_params.merge({album_id: cookies[:album_id]})
  end
end
