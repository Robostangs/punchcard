class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :user_id
      t.integer :meeting_id
      t.time :in_time
      t.time :out_time
      t.boolean :present , :default => false

      t.timestamps
    end
  end
end
