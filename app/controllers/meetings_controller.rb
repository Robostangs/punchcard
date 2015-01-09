class MeetingsController < ApplicationController
  def index
    @meeting = Meeting.all.reverse
  end

  def check
    @meeting = Meeting.find(params[:id])
    student_id = params['student_id']
    if not student_id == nil
      if @meeting.take_attendance(@meeting, student_id) == "does not exist"
        flash[:notice] = "Student ID does not exist in database."
      elsif @meeting.take_attendance(@meeting, student_id)
        flash[:notice] = "Successfully checked in. Please check out when you are done or else you will not recieve credit."
      elsif @meeting.take_attendance(@meeting, student_id) == false
        flash[:notice] = "Successfully checked out."
      end
    end
  end
end
