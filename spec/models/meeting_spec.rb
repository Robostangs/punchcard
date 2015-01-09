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
  describe 'take_attendance' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @meeting = FactoryGirl.create(:meeting)
    end

    context 'check in' do
      it 'adds a user to the meeting' do
        expect(@meeting.take_attendance(@meeting, @user.student_id)).to be_truthy
        expect(@meeting.users).to include @user
      end

      it 'adds a meeting to the user' do
        expect(@meeting.take_attendance(@meeting, @user.student_id)).to be_truthy
        expect(@user.meetings).to include @meeting
      end

      it 'sets in_time to Time.now in attendance' do
        expect(@meeting.take_attendance(@meeting, @user.student_id)).to be_truthy
        expect((Attendance.where({user: @user}).first).in_time).should be_truthy
      end
    end

    context 'check out' do
      it 'sets present to true' do
        expect(@meeting.take_attendance(@meeting, @user.student_id)).to be_truthy
        expect((Attendance.where({user: @user}).first).present?).should be_truthy
      end

      it 'sets out_time to Time.now in attendance' do
        expect(@meeting.take_attendance(@meeting, @user.student_id)).to be_truthy
        expect((Attendance.where({user: @user}).first).out_time).should be_truthy
      end
    end

    it 'does not allow user to check out a second time' do
      @meeting.take_attendance(@meeting, @user.student_id)
      @meeting.take_attendance(@meeting, @user.student_id)
      expect(@meeting.take_attendance(@meeting, @user.student_id)).to be_falsy
    end

    it 'makes sure that user exists by authenticating student_id' do
      student_id = rand
      expect(@meeting.take_attendance(@meeting, student_id)).to eql "does not exist"
    end
  end
end
