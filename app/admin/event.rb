ActiveAdmin.register Event do
  permit_params :id, :title, :description, :location, :event_date, :start_time, :end_time, :max_slots, :credits, :signup_deadline_date

  sidebar "Signups", only: [:show] do
    ul do
      link_to("Signups", admin_event_signups_path(event))
    end
  end

  index do
    selectable_column
    id_column
    column :title
    column :description
    column :location
    column :event_date
    column :start_time
    column :end_time
    actions
  end

  show do |event|
    attributes_table do
      row :title
      row :description
      row :location
      row :event_date
      row :start_time
      row :end_time
      row :credits
      row :max_slots
      row :signup_deadline_date
      row :slots_taken do
        "#{event.signups.count} / #{event.max_slots}"
      end
      row :currently_signed_up do
        event.users.map(&:name).join("<br />").html_safe
      end
    end
  end
end
