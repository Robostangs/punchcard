# == Schema Information
#
# Table name: events
#
#  id                   :integer          not null, primary key
#  title                :string(255)
#  description          :string(255)
#  location             :string(255)
#  event_date           :date
#  start_time           :time
#  end_time             :time
#  max_slots            :integer
#  credits              :float
#  signup_deadline_date :datetime
#  created_at           :datetime
#  updated_at           :datetime
#

FactoryGirl.define do
  factory :event do
    title "Event Title"
    description "Event Description"
    location "Event Location"
    max_slots 1
    event_date Time.now
    signup_deadline_date { Time.now + 5.minutes }
    credits 1.5
    start_time { Time.now }
    end_time { Time.now + 30.minutes }
  end
end
