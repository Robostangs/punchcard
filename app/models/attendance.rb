# == Schema Information
#
# Table name: attendances
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  meeting_id :integer
#  in_time    :time
#  out_time   :time
#  present    :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

class Attendance < ActiveRecord::Base
  belongs_to :user
  belongs_to :meeting

  def time_present
    self.out_time - self.in_time
  end
end
