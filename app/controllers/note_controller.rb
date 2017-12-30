class NoteController < ApplicationController
  before_action :set_note, only: [:destroy]
  
  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id if current_user
    respond_to do |format|
      if @note.save
        format.html { redirect_to URI(request.referer).path, notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { redirect_to URI(request.referer).path }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end
  

  def destroy
    
    @note.destroy
    respond_to do |format|
      format.html { redirect_to URI(request.referer).path, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:showing_id, :description)
    end
end
