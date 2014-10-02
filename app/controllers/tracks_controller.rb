class TracksController < ApplicationController
  before_action :login

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
    band_id = Band.find_by(name: params[:band_id]).id
    album_id = Album.find_by(name: params[:album_id], band_id: band_id).id
    @track = Track.find_by(name: params[:id], album_id: album_id)
    render :show
  end

  private
  def track_params
    track_params = params.require(:track).permit(:name, :lyrics, :track_type)
    band_id = Band.find_by(name: params[:band]).id
    album_id = Album.find_by(name: params[:album], band_id: band_id).id
    track_params.merge({album_id: album_id})
  end
end
