# == Schema Information
#
# Table name: meetings
#
#  id           :integer          not null, primary key
#  meeting_date :date
#  mandatory    :boolean
#  day          :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Meeting < ActiveRecord::Base
  has_many :users, :through => :attendances
end
