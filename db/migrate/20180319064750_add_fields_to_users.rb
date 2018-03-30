class AddFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :contact_number, :string
    add_column :users, :secondary_contact_number, :string
    add_column :users, :emergency_contact_person_name, :string
    add_column :users, :emergency_contact_person_relation, :string
    add_column :users, :emergency_contact_person_number, :string
    add_column :users, :dob, :date
    add_column :users, :permanent_address, :string
    add_column :users, :temporary_address, :string
    add_column :users, :bank_account_number, :string
    add_column :users, :employment_history, :jsonb
    add_column :users, :performance_evaluation, :jsonb
    add_column :users, :reporting_to, :integer
  end
end
