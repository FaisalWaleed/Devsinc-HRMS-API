class AddTypeAndDisplayNameToPermissions < ActiveRecord::Migration[5.1]
  def change
    add_column :permissions, :group, :string
    add_column :permissions, :display_name, :string
  end
end
