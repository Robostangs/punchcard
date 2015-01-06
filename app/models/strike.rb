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

class Strike < ActiveRecord::Base
  belongs_to :user
end
