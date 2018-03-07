class AddUsernameAndCompanyIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :username, :string
    add_index :users, :username, unique: true

    add_column :users, :company_id, :bigint, null: false
    add_index :users, :company_id
  end
end
