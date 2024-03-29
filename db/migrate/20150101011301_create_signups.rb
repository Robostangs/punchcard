class CreateSignups < ActiveRecord::Migration
  def change
    create_table :signups do |t|
      t.integer :user_id
      t.integer :event_id
      t.boolean :confirmed
      t.float :credits_earned

      t.timestamps
    end
  end
end
