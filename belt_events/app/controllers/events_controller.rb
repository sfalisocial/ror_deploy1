class EventsController < ApplicationController
  def index
    @states = State.all
    @user = User.find(session[:user_id])
    @my_state = Event.joins(:user).where('events.state_id = ?', @user.state_id).select(:date, :location, :name, :first_name, 'events.id AS events_id', :id)
    @other_states = Event.joins(:state).joins(:user).where('events.state_id != ?', @user.state_id).select( :date, :location, :name, 'states.name AS state_name', 'events.name AS name', :first_name, 'events.id AS events_id', :id)
    puts '**********'
    puts @other_states
  end

  def create
    form = params[:event]
    state = State.find(form[:state_id])
    user = current_user
    event = Event.new(event_params)
    event.user = user
    if event.save
      flash[:msg] = "Successfully created event!"
    else
      flash[:msg] = "Invalid credentials!"
    end
    redirect_to :back
  end

  def show
    id = params[:id]
    @event = Event.find(id)
    @details =  Event.joins(:state).joins(:user).where('events.id = '+id.to_s).select(:first_name, :date, 'events.location AS event_location', :name)

    @guest = Guest.where(event:@event)
    @guests = Guest.joins(:user).joins(:event).joins(user: :state).where(event:@event).select(:first_name, 'users.state_id AS user_state', 'users.location AS user_location', 'states.name AS state_name')
    @comments = Comment.joins(:user).where(event:@event).select(:content, :first_name)
  end

  def edit
    event = params[:id]
    @event = Event.find(event)
    @states = State.all
  end

  def update
    form = params[:event]
    @event = Event.find(params[:id])
    @event.attributes = event_params
    state = State.find(form[:state_id])
    @event.state = state
    if @event.save
      flash[:msg] = "Event successfully updated"
      redirect_to "/events"
    else
      flash[:msg] = @event.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    event = Event.find(params[:id])
    Event.find(params[:id]).destroy if event.user == current_user
    redirect_to :back
  end

  private
  def event_params
    params.require(:event).permit(:name, :date, :location, :state_id)
  end
end
