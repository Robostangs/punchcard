class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.date :meeting_date
      t.boolean :mandatory
      t.string :day

      t.timestamps
    end
  end
end
