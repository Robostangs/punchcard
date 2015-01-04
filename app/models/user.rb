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
#  admin                  :boolean

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :signups
  has_many :attendances
  has_many :strikes
  has_many :events, :through => :signups
  has_many :meetings, :through => :attendances

  def number_of_strikes
    self.strikes.count
  end

  def full_name
    self.first_name + ' ' + self.last_name
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

  def confirmed_credits
    confirmed_creditss = 0.0;
    self.signups.each do |signup|
      if signup.confirmed then confirmed_creditss += signup.credits_earned end
    end
    confirmed_creditss
  end

  def pending_credits
    pending_creditss = 0.0
    self.signups.each do |signup|
      if not signup.confirmed then pending_creditss += signup.credits_earned end
    end
    pending_creditss
  end

  def total_credits
    (self.pending_credits + self.confirmed_credits)
  end

  def meeting_attendance
    present_at = 0
    self.attendances.each { |attend| if attend.present then present_at += 1 end }
    (present_at / self.attendances.count.to_f) * 100
  end

  def missed_mandatory_meetings
    missed = 0
    self.attendances.each { |attend| if attend.mandatory and not attend.present then missed += 1 end }
    missed
  end
end
