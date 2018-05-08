class AddLeavesQuotaToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :leaves_quota, :integer, :default => 14
  end
end
