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

class Event < ActiveRecord::Base
  has_many :signups
  has_many :users, :through => :signups

  def full?
    self.signups.count >= self.max_slots
  end

  def slots_left
    self.max_slots - self.signups.count
  end
end
