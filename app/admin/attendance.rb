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
end
