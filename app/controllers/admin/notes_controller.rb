class Admin::NotesController < ApplicationController

  def create
    @note = Note.create(note_params)
    redirect_to :back
  end

  def update
    @note = Note.find(params[:id])
    @note.update(user_params)
    redirect_to :back
  end

  def destroy
    Note.find(params[:id]).destroy
    redirect_to :back
  end

  private
    def note_params
      params.require(:note).permit!
    end

end
