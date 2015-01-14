class MeetingsController < ApplicationController
  def index
    @meeting = Meeting.all.reverse
  end

  def check
    @meeting = Meeting.find(params[:id])
    student_id = params['student_id']
    if student_id.to_s.chr == 'S'
      student_id.delete! 'S'
    end
    if not student_id == nil
      flashAttendance = @meeting.take_attendance(@meeting, student_id).to_s
      if flashAttendance == 'User does not exist.'
        flash[:notice] = 'User does not exist.'
      elsif flashAttendance == 'Checked out.'
        flash[:notice] = 'Successfully checked out.'
      elsif flashAttendance == 'Checked in.'
        flash[:notice] = 'Successfully checked in.'
      end
    end
  end
end
