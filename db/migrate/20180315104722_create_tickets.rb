class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.references :user, foreign_key: true
      t.integer :department_id
      t.integer :role_id
      t.string :title
      t.string :description
      t.date :due_date

      t.timestamps
    end
  end
end
