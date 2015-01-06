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

FactoryGirl.define do
  factory :attendance do
    user_id 1
    meeting_id 1
    in_time Time.now
    out_time { Time.now + 30.minutes }
    present false
  end
end
