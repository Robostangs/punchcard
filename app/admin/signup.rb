ActiveAdmin.register Signup do
  belongs_to :event

  index do
    selectable_column
    column :event
    column "Event Date" do |signup|
      signup.event.event_date
    end
    column "Name" do |signup|
      signup.user.name
    end
    column "Confirmed", :sortable => :confirmed do |signup|
      if signup.confirmed then
        "Yes"
      else
        "No"
      end
    end
    actions
  end

  batch_action :confirm do |selection|
    Signup.find(selection).each do |signup|
      signup.confirmed = true
      signup.save
    end
    redirect_to :back
  end

  batch_action :unconfirm do |selection|
    Signup.find(selection).each do |signup|
      signup.confirmed = false
      signup.save
    end
    redirect_to :back
  end

  action_item :only => :index do
    link_to 'Add all users to event', :action => 'add_all_users'
  end

  collection_action :add_all_users do
    event = Event.where({id: params[:event_id]}).first
    User.all.each do |user|
      if not Signup.where({user: user, event: event}).any?
        signup = Signup.create({user: user, event: event})
      end
    end
    redirect_to :action => :index
  end
end
