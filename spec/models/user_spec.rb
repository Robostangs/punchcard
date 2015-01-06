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

require 'rails_helper'

RSpec.describe User, :type => :model do
  describe "signup_for" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @event = FactoryGirl.create(:event)
    end

    it 'adds a user to the event' do
      expect(@user.signup_for(@event)).to be_truthy
      expect(@event.users).to include @user
    end

    it 'adds the event to user' do
      expect(@user.signup_for(@event)).to be_truthy
      expect(@user.events).to include @event
    end

    it 'does not allow a user to signup past deadline' do
      @event.signup_deadline_date = Time.now - 5.minutes
      expect(@user.signup_for(@event)).to be_falsy
      expect(@user.events).not_to include @event
      expect(@event.users).not_to include @user
    end

    it 'expects the event to exist' do
      @event = nil
      expect(@user.signup_for(@event)).to be_falsy
    end

    it 'does not allow a user to signup twice' do
      expect(@user.signup_for(@event)).to be_truthy
      expect(@user.signup_for(@event)).to be_falsy
    end
  end

  describe 'backout_from' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @event = FactoryGirl.create(:event)
      @user.signup_for(@event)
    end

    it 'removes the user from the event' do
      expect(@user.backout_from(@event)).to be_truthy
      expect(@user.events).not_to include @event
    end

    it 'removes the event from the user' do
      expect(@user.backout_from(@event)).to be_truthy
      expect(@event.users).not_to include @user
    end

    it 'does not allow the user to backout past the deadline' do
      @event.signup_deadline_date = Time.now - 5.minutes
      expect(@user.backout_from(@event)).to be_falsy
      expect(@event.users).to include @user
      expect(@user.events).to include @event
    end

    it 'expects the event to exist' do
      @event = nil
      expect(@user.backout_from(@event)).to be_falsy
    end
  end

  describe 'check_in' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @meeting = FactoryGirl.create(:meeting)
    end

    it 'adds a user to the meeting' do
      expect(@user.check_in(@meeting)).to be_truthy
      expect(@meeting.users).to include @user
    end

    it 'adds a meeting to the user' do
      expect(@user.check_in(@meeting)).to be_truthy
      expect(@user.meetings).to include @meeting
    end

    # it 'adds an in_time to the attendance' do
    #   @user.check_in(@meeting)
    #   attendance = Attendance.find_by({user: @user, meeting: @meeting})
    #   expect(attendance.in_time).to eql Time.now
    # end
    # attendance returns 2000-01-01 but when you put attendance.time_in it is Time.now wtf

    it 'expects the event to exist' do
      @meeting = nil
      expect(@user.check_in(@meeting)).to be_falsy
    end

    it 'does not allow a user to check in twice' do
      expect(@user.check_in(@meeting)).to be_truthy
      expect(@user.check_in(@meeting)).to be_falsy
    end
  end

  describe 'check_out' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @meeting = FactoryGirl.create(:meeting)
      @user.check_in(@meeting)
      expect(@meeting.users).to include @user
      expect(@user.meetings).to include @meeting
    end

    it 'checks out the user' do
      expect(@user.check_out(@meeting)).to be_truthy
    end

    # it 'adds an out_time to the user' do
    #   @user.check_out(@meeting)
    #   attendance = Attendance.find_by({user: @user, meeting: @meeting})
    #   expect(attendance.out_time).to eql Time.now
    # end
    # attendance returns 2000-01-01 but when you put attendance.time_out it is Time.now wtf

    it 'confirms the attendance of user' do
      @user.check_out(@meeting)
      attendance = Attendance.find_by({user: @user, meeting: @meeting})
      expect(attendance.present).to eql true
    end

    it 'expects the meeting to exist' do
      @meeting = nil
      expect(@user.check_in(@meeting)).to be_falsy
    end
  end
end
