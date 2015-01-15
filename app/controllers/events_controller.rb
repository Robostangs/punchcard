class EventsController < ApplicationController
  def index
    @event = Event.all.reverse
  end

  def show
    @event = Event.find(params[:id])
  end

  def signup
    @event = Event.find(params[:id])
    feedback = current_user.signup_for(@event)
    flash[:notice] = feedback
    redirect_to event_path(@event)
  end

  def backout
    @event = Event.find_by_id(params[:id])
    feedback = current_user.backout_from(@event)
    flash[:notice] = feedback
    redirect_to event_path(@event)
  end
end
