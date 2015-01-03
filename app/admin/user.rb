ActiveAdmin.register User do
  index do
    selectable_column
    id_column
    column :name do |user|
      user.full_name
    end
    column :email
    column :school_id
    column :attendance do |user|
      (user.meeting_attendance).to_s + '%'
    end
    column :credits do |user|
      user.confirmed_credits
    end
    column :strikes do |user|
      user.number_of_strikes
    end
    actions
  end
end
