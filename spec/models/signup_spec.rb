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

require 'rails_helper'

RSpec.describe Signup, :type => :model do
end
