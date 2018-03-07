class AddDepartmentsToCompany < ActiveRecord::Migration[5.1]
  def change
    create_table :company_departments do |t|
      t.references :company, foreign_key: true
      t.references :department, foreign_key: true
    end
    add_index :company_departments, %i[company_id department_id], unique: true
  end
end
