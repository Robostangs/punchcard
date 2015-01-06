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

require 'rails_helper'

RSpec.describe Strike, :type => :model do
end
