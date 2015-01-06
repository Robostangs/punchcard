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
      if signup.confirmed then "Yes"
      else "No"
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
end
