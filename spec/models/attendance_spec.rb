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

require 'rails_helper'

RSpec.describe Attendance, :type => :model do
end
