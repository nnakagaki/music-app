class NotesController < ApplicationController
  before_action :login, :band_update, :album_update, :track_update

  def create
    note = Note.new(note_params)
    flash[:errors] = note.errors.full_messages unless note.save

    redirect_to band_album_track_url(id: params[:track_id])
  end

  def destroy

  end

  private
  def note_params
    note_params = params.require(:note).permit(:body)
    note_params.merge({user_id: current_user.id, track_id: cookies[:track_id]})
  end

end
