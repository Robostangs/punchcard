ActiveAdmin.register Meeting do
  permit_params :meeting_date, :meeting_time, :description, :mandatory

  index do
    selectable_column
    id_column
    column :meeting_date
    column :meeting_time
    column :description
    column :mandatory
    column :attended do |meeting|
      meeting.attended
    end
    actions
  end

  show do |meeting|
    attributes_table do
      row :meeting_date
      row :meeting_time
      row :description
      row :mandatory
      row :attendances do |meeting|
        link_to("Attendances", admin_meeting_attendances_path(meeting))
      end
    end
  end

  form do |f|
    f.inputs "Meeting Details" do
      f.input :meeting_date
      f.input :meeting_time
      f.input :description
      f.input :mandatory
    end
    f.actions
  end
end
