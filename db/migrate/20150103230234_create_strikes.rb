class CreateStrikes < ActiveRecord::Migration
  def change
    create_table :strikes do |t|
      t.string :reason
      t.integer :user_id

      t.timestamps
    end
  end
end
