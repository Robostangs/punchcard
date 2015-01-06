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

FactoryGirl.define do
  factory :meeting do
    meeting_date "2099-12-12"
    meeting_time Time.now
    mandatory false
    description "General meeting"
  end
end
