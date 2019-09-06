class InvitationsController < ApplicationController
  def create
    @invitation = Invitation.new 
    @invitation.attendee_id = current_user.id 
    @invitation.attended_event_id = params[:id]
    if @invitation.save 
      flash[:success] = "Yay, you will attend this event."
      redirect_to events_path
    else 
      flash[:danger] = "Sorry, but something went wrong."
      redirect_to events_path
    end
  end
end
