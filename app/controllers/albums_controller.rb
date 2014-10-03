class AlbumsController < ApplicationController
  before_action :login, :band_update

  def new
    @band_name = cookies[:band_name]
    render :new
  end

  def create
    album = Album.new(album_params)
    if album.save
      redirect_to band_album_url({band_id: params[:band_id], id: album.name})
    else
      flash.now[:errors] = album.errors.full_messages
      @band_name = cookies[:band_name]
      render :new
    end
  end

  def show
    @album = Album.find_by(name: params[:id], band_id: cookies[:band_id])
    render :show
  end

  def destroy
    Album.find_by(name: params[:id], band_id: cookies[:band_id]).destroy
    redirect_to band_url(band.name)
  end

  private
  def album_params
    album_params = params.require(:album).permit(:name, :album_type)
    album_params.merge({band_id: cookies[:band_id]})
  end
end
