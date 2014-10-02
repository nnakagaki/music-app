class AlbumsController < ApplicationController
  def new
    @band = Band.find_by(name: params[:band_id])
    render :new
  end

  def create
    album = Album.new(album_params)
    if album.save
      redirect_to band_album_url({band_id: params[:band_name], id: album.name})
    else
      flash.now[:errors] = album.errors.full_messages
      @band = Band.find_by(name: params[:band_id])
      render :new
    end
  end

  def show
    band_id = Band.find_by(name: params[:band_id]).id
    @album = Album.find_by(name: params[:id], band_id: band_id)
    render :show
  end

  def destroy
    band = Band.find_by(name: params[:band_id])
    Album.find_by(name: params[:id], band_id: band.id).destroy
    redirect_to band_url(band.name)
  end

  private
  def album_params
    album_params = params.require(:album).permit(:name, :album_type)
    band_id = Band.find_by(name: params[:band_name]).id
    album_params.merge({band_id: band_id})
  end
end
