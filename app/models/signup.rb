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
  before_create :set_credits
  belongs_to :user
  belongs_to :event

  def set_credits
    self.credits_earned = self.event.credits
  end
end
