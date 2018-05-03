class ChangeToLeaveStatusTable < ActiveRecord::Migration[5.1]
  def change
    remove_column :leave_statuses, :active
    add_column :leave_statuses, :comment, :string
    rename_column :leave_statuses, :changed_by_user_id, :user_id
  end
end
