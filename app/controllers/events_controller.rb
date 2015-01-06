class EventsController < ApplicationController
  def index
    @event = Event.all.reverse
  end

  def show
    @event = Event.find(params[:id])
  end

  def signup
    @event = Event.find(params[:id])
    if current_user.signup_for(@event)
      flash[:notice] = "Signed up for event."
      redirect_to event_path(@event)
    else
      flash[:error] = "Could not signup for event."
      redirect_to event_path(@event)
    end
  end

  def backout
    @event = Event.find_by_id(params[:id])
    if current_user.backout_from(@event)
      flash[:notice] = "Backed out successfully."
      redirect_to event_path(@event)
    else
      flash[:error] = "Back out deadline has passed."
      redirect_to event_path(@event)
    end
  end
end
