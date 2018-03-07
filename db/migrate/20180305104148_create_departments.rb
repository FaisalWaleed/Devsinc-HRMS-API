class CreateDepartments < ActiveRecord::Migration[5.1]
  def change
    create_table :departments do |t|
      t.string  :name, index: true, unique: true, null: false
      t.string  :description, null: false

      t.timestamps
    end
  end
end
