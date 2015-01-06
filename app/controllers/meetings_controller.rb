class MeetingsController < ApplicationController
  def index
    @meeting = Meeting.all.reverse
  end

  def check
    @meeting = Meeting.find(params[:id])
    student_id = params['student_id']
    if @meeting.take_attendance(@meeting, student_id)
      flash[:notice] = "Successfully signed in. Please signout when you are done or else you will not recieve credit."
    elsif @meeting.take_attendance(@meeting, student_id) == false
      flash[:notice] = "Successfully signed out."
    end
  end
end
