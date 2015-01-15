ActiveAdmin.register Attendance do
  belongs_to :meeting

  index do
    selectable_column
    id_column
    column :meeting
    column "Meeting Date" do |attendance|
      attendance.meeting.meeting_date
    end
    column "User name" do |attendance|
      if attendance.user then
        attendance.user.name
      end
    end
    column "Present", :sortable => :confirmed do |attendance|
      if attendance.present then
        "Yes"
      else
        "No"
      end
    end
    actions
  end

  batch_action :confirm do |selection|
    Attendance.find(selection).each do |attendance|
      attendance.present = true
      attendance.save
    end
    redirect_to :back
  end

  action_item :only => :index do
    link_to 'Add all users to meeting', :action => 'add_users'
  end

  collection_action :add_users do
    meeting = Meeting.where({id: params[:meeting_id]}).first
    User.all.each do |user|
      if not Attendance.where({user: user, meeting: meeting}).any?
        attendance = Attendance.create({user: user, meeting: meeting})
      end
    end
    redirect_to :action => :index
  end
end
