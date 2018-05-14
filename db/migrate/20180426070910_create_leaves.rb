class CreateLeaves < ActiveRecord::Migration[5.1]
  def change
    create_table :leaves do |t|
      t.references :user, foreign_key: true
      t.string :leave_type
      t.text :reason
      t.date :start_date
      t.date :end_date

      t.timestamps

    end
  end
end
