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

class Signup < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
end
