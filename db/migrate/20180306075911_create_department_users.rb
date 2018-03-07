class CreateDepartmentUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :department_users do |t|
      t.references :department, foreign_key: true
      t.references :user, foreign_key: true
    end
    add_index :department_users, %i[department_id user_id], unique: true
  end
end
