FactoryGirl.define do
  factory :event, :class => 'Event' do
    title "MyString"
    descriprion "MyString"
    max_slots 1
    event_date Time.now
    signup_deadline_date { Time.now + 5.minutes }
    credits 1.5
    start_time { Time.now }
    end_time { Time.now + 30.minutes }
  end

end
