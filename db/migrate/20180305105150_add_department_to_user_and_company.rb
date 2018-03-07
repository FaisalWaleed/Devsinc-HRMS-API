class AddDepartmentToUserAndCompany < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :department, foreign_key: true, null: false
    add_reference :departments, :company, foreign_key: true, null: false
  end
end
