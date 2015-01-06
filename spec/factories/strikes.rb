# == Schema Information
#
# Table name: strikes
#
#  id         :integer          not null, primary key
#  reason     :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :strike do
    reason "Broke robot"
    user_id 1
  end
end
