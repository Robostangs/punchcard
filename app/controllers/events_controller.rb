class EventsController < ApplicationController
  def index
    @event = Event.all.reverse
  end

  def show
    @event = Event.find(params[:id])
  end

  def signup
    @event = Event.find(params[:id])
    if current_user.signup_for(@event) == "Event does not exist."
      flash[:error] = "Event does not exist."
      redirect_to event_path(@event)
    elsif current_user.signup_for(@event) == "Already signed up."
      flash[:error] = "Already signed up."
      redirect_to event_path(@event)
    elsif current_user.signup_for(@event) == "Past deadline."
      flash[:error] = "The deadline for signing up has passed."
      redirect_to event_path(@event)
    elsif current_user.signup_for(@event)
      flash[:notice] = "Signed up successfully."
      redirect_to event_path(@event)
    end
  end

  def backout
    @event = Event.find_by_id(params[:id])
    if current_user.backout_from(@event) == "Event does not exist."
      flash[:error] = "Event does not exist."
      redirect_to event_path(@event)
    elsif current_user.backout_from(@event) == "Past deadline."
      flash[:error] = "The deadline for backing out has passed."
      redirect_to event_path(@event)
    elsif current_user.backout_from(@event) == "You are already confirmed."
      flash[:error] = "You are already confirmed."
      redirect_to event_path(@event)
    elsif current_user.backout_from(@event)
      flash[:notice] = "Backed out successfully."
      redirect_to event_path(@event)
    end
  end
end
