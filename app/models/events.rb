class Events < ActiveRecord::Base
  has_many :users, :through => :signups
end
