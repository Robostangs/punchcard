class EventsController < ApplicationController
  def create
  end
  def new
  end
  def show
  end
  def edit
  end
  def destroy
  end

  def signup
    @event = Event.find(params[:id])
    if current_user.signup_for(@event)
      flash[:notice] = "Signed Up for Event"
      redirect_to event_path(@event)
    else
      flash[:error] = "Could Not Sign Up for Event"
      redirect_to event_path(@event)
    end
  end

  def backout
    @event = Event.find(params[:id])
    if current_user.backout_from(@event)
      flash[:notice] = "Successfully Backed Out!"
      redirect_to event_path(@event)
    else
      flash[:error] = "Back Out Deadline has Passed!"
      redirect_to event_path(@event)
    end
  end
end
