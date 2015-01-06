# == Schema Information
#
# Table name: signups
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  event_id       :integer
#  confirmed      :boolean
#  credits_earned :float
#  created_at     :datetime
#  updated_at     :datetime
#

FactoryGirl.define do
  factory :signup do
    user_id 1
    event_id 1
    confirmed false
    credits_earned 1.5
  end
end
