# == Schema Information
#
# Table name: meetings
#
#  id           :integer          not null, primary key
#  meeting_date :date             not null
#  meeting_time :time             not null
#  description  :string(255)      default("General meeting")
#  mandatory    :boolean          default(FALSE)
#  created_at   :datetime
#  updated_at   :datetime
#

class Meeting < ActiveRecord::Base
  has_many :attendances
  has_many :users, :through => :attendances

  def attended
    present = 0
    total = self.attendances.count
    self.attendances.each do |attendance|
      if attendance.present?
        present += 1
      end
    end
    present.to_s + '/' + total.to_s
  end

  def take_attendance(meeting, student_id)
    if meeting.nil?
      false
    elsif Attendance.where({user: User.where({student_id: student_id}).first, meeting: meeting}).any?
      attendance = Attendance.where({user: User.where({student_id: student_id}).first, meeting: meeting}).first
      attendance.present = true
      attendance.out_time = Time.now
      attendance.save
      false
    else
      attendance = Attendance.create({user: User.where({student_id: student_id}).first, meeting: meeting})
      attendance.in_time = Time.now
      attendance.save
      true
    end
  end
end
