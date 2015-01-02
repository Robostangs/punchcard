# == Schema Information
#
# Table name: strikes
#
#  id         :integer          not null, primary key
#  date_given :date
#  reason     :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Strike < ActiveRecord::Base
end
