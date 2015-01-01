class Meeting < ActiveRecord::Base
  has_many :users, :through => :attendances
end
