class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.string :location
      t.date :event_date
      t.time :start_time
      t.time :end_time
      t.integer :max_slots
      t.float :credits
      t.datetime :signup_deadline_date

      t.timestamps
    end
  end
end
