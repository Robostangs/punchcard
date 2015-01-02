# == Schema Information
#
# Table name: events
#
#  id                   :integer          not null, primary key
#  title                :string(255)
#  descriprion          :string(255)
#  max_slots            :integer
#  event_date           :date
#  signup_deadline_date :string(255)
#  credits              :float
#  start_time           :time
#  end_time             :time
#  created_at           :datetime
#  updated_at           :datetime
#

class Event < ActiveRecord::Base
  has_many :users, :through => :signups
end
