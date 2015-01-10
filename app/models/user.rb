# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
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
#  name                   :string(255)
#  student_id             :string(255)
#  admin                  :boolean          default(FALSE)
#  created_at             :datetime
#  updated_at             :datetime
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

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

  def signup_for(event)
    if event.nil? # Event doesn't exist
      false
    elsif Signup.where({user: self, event: event}).any? # Existing signup
      false
    elsif event.signup_deadline_date < Time.now # Past deadline
      false
    else
      Signup.create({user: self, event: event})
    end
  end

  def backout_from(event)
    if event.nil? # Event doesn't exist
      false
    elsif event.signup_deadline_date < Time.now # Past deadline
      false
    else
      Signup.where({user: self, event: event}).destroy_all
    end
  end

  def number_of_strikes
    self.strikes.count
  end

  def confirmed_credits
    confirmed = 0.0
    self.signups.each do |signup|
      if signup.confirmed then confirmed += signup.credits_earned.to_f end
    end
    confirmed
  end

  def pending_credits
    pending = 0.0
    self.signups.each do |signup|
      if not signup.confirmed then pending += signup.credits_earned.to_f end
    end
    pending
  end

  def total_credits
    self.pending_credits + self.confirmed_credits
  end

  def meeting_statistic
    present_at = 0
    self.attendances.each { |attend| if attend.present then present_at += 1 end }
    present_at.to_s + '/' + Meeting.count.to_s
  end

  def meeting_attendance
    present_at = 0
    self.attendances.each { |attend| if attend.present then present_at += 1 end }
    if present_at == 0
      '0%'
    else
      (((present_at / Meeting.count.to_f) * 100).to_f).round(2).to_s. + '%'
    end
  end

 def missed_mandatory_meetings
    missed = 0
    Meeting.all.each { |meeting| if meeting.mandatory and not (Attendance.where({meeting: meeting, user: self}).first).present? then missed += 1 end }
    missed
  end

  def total_time
    time_present = 0.0
    self.attendances.each { |attend| if attend.present then time_present += attend.time_present end }
    (time_present/60).round(2).to_s + ' minutes'
  end
end
