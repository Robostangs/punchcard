class ChangeDeadlineTo < ActiveRecord::Migration
  def change
    change_column :events , :signup_deadline_date, :datetime
  end
end
