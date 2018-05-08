class CreateLeaveStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :leave_statuses do |t|
      t.references :leave, foreign_key: true
      t.string :status
      t.boolean :active
      t.integer :changed_by_user_id

      t.timestamps
    end
  end
end
