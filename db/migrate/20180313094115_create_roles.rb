class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.string :title, null: false
      t.text :description
      t.references :department, index: true, null: false

      t.timestamps
    end
  end
end
