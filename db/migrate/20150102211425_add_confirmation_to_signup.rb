class AddConfirmationToSignup < ActiveRecord::Migration
  def change
    add_column :singups, :confirmed, :boolean
  end
end
