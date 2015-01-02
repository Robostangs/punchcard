# == Schema Information
#
# Table name: attendances
#
#  id         :integer          not null, primary key
#  present    :boolean
#  in_time    :time
#  out_time   :time
#  user_id    :integer
#  meeting_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Attendance < ActiveRecord::Base
  belongs_to :user
end
