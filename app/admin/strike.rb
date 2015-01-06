ActiveAdmin.register Strike do
  permit_params :reason
  belongs_to :user

  index do
    id_column
    column :date_recieved do |strike|
      strike.created_at
    end
    column :reason
  end
end
