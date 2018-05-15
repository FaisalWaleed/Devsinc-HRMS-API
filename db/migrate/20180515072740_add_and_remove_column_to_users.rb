class AddAndRemoveColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :join_date, :date
    add_column :users, :buddy_id, :integer
    remove_column :users, :name
    remove_column :users, :leaves_quota
  end
end
