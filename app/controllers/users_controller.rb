class UsersController < ApplicationController
    def index 
        @users = User.all
    end

    def new 
        @user = User.new 
    end

    def create 
        @user = User.new(user_params)
        if @user.save 
            log_in @user
            flash[:success] = "Welcome to the Events App!"
            redirect_to @user 
        else 
            render "new"
        end
    end

    def show
        @user = User.find(params[:id]) 
        @created_events = Event.all.where(creator_id: params[:id])
        @attended_events = @user.attended_events
        @upcoming_events = @attended_events.upcoming
        @previous_events = @attended_events.previous
    end

    private 
        def user_params 
            params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end
end
