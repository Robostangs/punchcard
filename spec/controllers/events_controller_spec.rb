require 'rails_helper'

RSpec.describe EventsController, :type => :controller do
  let (:user) { FactoryGirl.create(:user) }

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  before(:each) do
    @event = FactoryGirl.create(:event)
  end

  describe "PATCH signup" do
    it 'adds the event to the user' do
      patch :signup, {id: @event.id}
      expect(@event.users).to include user
    end

    it 'adds the user to the event' do
      patch :signup, {id: @event.id}
      expect(user.events).to include @event
    end

    it 'does not allow a user to signup past the deadline' do
      @event.signup_deadline_date = Time.now - 5.minutes
      @event.save
      put :signup, {id: @event.id}
      expect(user.events).not_to include @event
    end
  end

  describe "PATCH backout" do
    it 'removes the event from the user' do
      patch :backout, {id: @event.id}
      expect(@event.users).not_to include user
    end

    it 'removes the user from the event' do
      patch :backout, {id: @event.id}
      expect(user.events).not_to include @event
    end

    it 'does not allow a user to backout past the deadline' do
      @event.signup_deadline_date = Time.now - 5.minutes
      @event.save
      put :backout, {id: @event.id}
      expect(user.events).not_to include @event
    end
  end
end
