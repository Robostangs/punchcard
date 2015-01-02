# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  school_id              :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :attendances
  has_many :strikes
  has_many :events, :through => :signups
  has_many :meetings, :through => :attendances
  has_many :signups


  def number_of_strikes
    self.strikes.count
  end
  def meetings_attendance_percent

  end

  def signup_for(event)
    if event.nil?                                           # Event doesn't exist
      false
    elsif Signup.where({user: self, event: event}).any?     # Existing signup
      false
    elsif event.signup_deadline_date < Time.now             # Past deadline
      false
    else
      Signup.create({user: self, event: event})
    end
  end

  def backout_from(event)
    if event.nil?                                           # Event doesn't exist
      false
    elsif event.signup_deadline_date < Time.now             # Past deadline
      false
    else
      Signup.where({user: self, event: event}).destroy_all
    end
  end
end
