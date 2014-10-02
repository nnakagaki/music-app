class NotesController < ApplicationController
  before_action :login

  def create
    note = Note.new(note_params)
    note.save
    flash[:errors] = note.errors.full_messages

    redirect_to band_album_track_url(id: params[:track_id])
  end

  def destroy

  end

  private
  def note_params
    note_params = params.require(:note).permit(:body)
    band_id = Band.find_by(name: params[:band_id]).id
    album_id = Album.find_by(name: params[:album_id], band_id: band_id).id
    track_id = Track.find_by(name: params[:track_id], album_id: album_id).id
    note_params.merge({user_id: current_user.id, track_id: track_id})
  end

end
