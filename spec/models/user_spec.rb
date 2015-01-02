require 'rails_helper'

RSpec.describe User, :type => :model do

  describe "signup_for" do
    context "A user signs up for an event" do
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

      it 'creates a signup' do
        expect(@user.signup_for(@event)).to be_truthy
        signup = @user.signups.last
        expect(signup.user).to eql @user
        expect(signup.event).to eql @event
      end
    end

    context "Deadlines" do

      before(:each) do
        @user = FactoryGirl.create(:user)
      end

      it 'does not allow a user to signup past deadline' do
        @event = FactoryGirl.create(:event, signup_deadline_date: Time.now - 5.minutes)
        expect(@user.signup_for(@event)).to be_falsy
        expect(@user.events).not_to include @event
        expect(@event.users).not_to include @user
      end
    end
  end

  describe 'backout from' do
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
      @event.save
      expect(@user.backout_from(@event)).to be_falsy
      expect(@event.users).to include @user
      expect(@user.events).to include @event
    end
  end
end
