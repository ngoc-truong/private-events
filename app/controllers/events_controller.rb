class EventsController < ApplicationController
    def index 
        @events = Event.all
        @previous_events = Event.previous
        @upcoming_events = Event.upcoming
    end

    def new
        @event = Event.new
    end

    def create
        @event = current_user.created_events.build(event_params)
        if @event.save 
            redirect_to current_user
        else 
            render "new"
        end
    end

    def show
        @event = Event.find(params[:id])
        @creator = User.find(@event.creator_id)
        @attendees = @event.attendees
    end

    private 

        def event_params
            params.require(:event).permit(:date, :location)
        end
end
