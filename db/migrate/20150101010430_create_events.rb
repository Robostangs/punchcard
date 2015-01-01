class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :descriprion
      t.integer :max_slots
      t.date :event_date
      t.string :signup_deadline_date
      t.float :credits
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
