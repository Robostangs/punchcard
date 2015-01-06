require 'rails_helper'

RSpec.describe EventsController, :type => :controller do
  describe 'POST signup' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @event = FactoryGirl.create(:event)
    end

    it 'adds a user to the event' do
      expect(response).to be_truthy
      expect(@event.users).to include @user
    end
  end
end
