require 'rails_helper'

RSpec.describe MeetingsController, :type => :controller do
  let (:user) { FactoryGirl.create(:user) }

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  before(:each) do
    @meeting = FactoryGirl.create(:meeting)
  end

  describe 'POST check' do
    context 'check in' do
      it 'adds the meeting to the user' do
        post :check, {id: @meeting.id, student_id: user.student_id}
        expect(@meeting.users).to include user
      end

      it 'adds the user to the meeting' do
        post :check, {id: @meeting.id, student_id: user.student_id}
        expect(user.meetings).to include @meeting
      end

      it 'sets in_time on meeting attendance for user' do
        post :check, {id: @meeting.id, student_id: user.student_id}
        expect((Attendance.where({user: user, meeting: @meeting}).first).in_time).to be_truthy
      end
    end

    context 'check out' do
      before(:each) do
        post :check, {id: @meeting.id, student_id: user.student_id}
      end

      it 'sets out_time on meeting attendance for user' do
        post :check, {id: @meeting.id, student_id: user.student_id}
        expect((Attendance.where({user: user, meeting: @meeting}).first).out_time).to be_truthy
      end

      it 'sets present on meeting attendance for user' do
        post :check, {id: @meeting.id, student_id: user.student_id}
        expect((Attendance.where({user: user, meeting: @meeting}).first).present).to be_truthy
      end
    end

    it 'does not allow wrong student ids' do
      post :check, {id: @meeting.id, student_id: rand}
      expect "does not exist"
    end
  end
end
