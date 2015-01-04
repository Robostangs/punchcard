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

    it 'does now allow a user to signup twice' do
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

  context 'Attendance' do

    before(:each) do
      @user = FactoryGirl.create(:user)

      # Signup for 5 events
      5.times do
        event = FactoryGirl.create(:event)
        @user.signup_for(event)
        signup = @user.signups.last
        signup.credits_earned = 2
        signup.confirmed = false
        signup.save
      end

      # Confirm 2 events
      @user.signups.take(2).each do |signup|
        signup.confirmed = true
        signup.save
      end
    end

    it 'has confirmed credits' do
      expect(@user.confirmed_credits).to eq 4
    end

    it 'has pending credits' do
      expect(@user.pending_credits).to eq 6
    end

    it 'has total credits' do
      expect(@user.total_credits).to eq 10
    end
  end

end
