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

require 'rails_helper'

RSpec.describe Event, :type => :model do
end
