class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @user ||= User.find_by(session_token: session[:session_token])
  end

  def band_update
    if cookies[:band_name].nil?
      @band = Band.find_by(name: params[:band_id])
    elsif cookies[:band_name] != params[:band_id]
      @band = Band.find_by(name: params[:band_id])
    end

    if @band
      cookies[:band_name] = @band.name
      cookies[:band_id] = @band.id
    end
  end

  def album_update
    if cookies[:album_name].nil?
      @album = Album.find_by(name: params[:album_id], band_id: cookies[:band_id])
    elsif cookies[:album_name] != params[:album_id]
      @album = Album.find_by(name: params[:album_id], band_id: cookies[:band_id])
    end

    if @album
      cookies[:album_name] = @album.name
      cookies[:album_id] = @album.id
    end
  end

  def track_update
    if cookies[:track_name].nil?
      @track = Track.find_by(name: params[:track_id], album_id: cookies[:album_id])
    elsif cookies[:track_name] != params[:track_id]
      @track = Track.find_by(name: params[:track_id], album_id: cookies[:album_id])
    end

    if @track
      cookies[:track_name] = @track.name
      cookies[:track_id] = @track.id
    end
  end

  def logged_in?
    !!current_user
  end

  def login
    redirect_to new_session_url unless logged_in?
  end

  helper_method :logged_in?, :current_user

end
