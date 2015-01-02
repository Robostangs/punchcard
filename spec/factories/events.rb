FactoryGirl.define do
  factory :event, :class => 'Event' do
    title "MyString"
    descriprion "MyString"
    max_slots 1
    event_date "2014-12-31"
    signup_deadline_date "MyString"
    credits 1.5
    start_time "2014-12-31 20:04:30"
    end_time "2014-12-31 20:04:30"
  end

end
