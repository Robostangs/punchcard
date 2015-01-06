# == Schema Information
#
# Table name: meetings
#
#  id           :integer          not null, primary key
#  meeting_date :date             not null
#  meeting_time :time             not null
#  description  :string(255)      default("General meeting")
#  mandatory    :boolean          default(FALSE)
#  created_at   :datetime
#  updated_at   :datetime
#

require 'rails_helper'

RSpec.describe Meeting, :type => :model do
end
