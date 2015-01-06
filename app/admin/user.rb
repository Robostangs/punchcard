ActiveAdmin.register User do
  permit_params :email, :name, :student_id, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :student_id
    column :attendance do |user|
      user.meeting_attendance
    end
    column :credits do |user|
      user.confirmed_credits
    end
    column :strikes do |user|
      user.number_of_strikes
    end
    column :admin
    actions
  end

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :name
      f.input :student_id
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  sidebar "Strikes", only: [:show] do
    ul do
      link_to("Strikes", admin_user_strikes_path(user))
    end
  end
end
