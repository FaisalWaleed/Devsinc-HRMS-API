class CreateTicketUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :ticket_users do |t|
      t.references :ticket, foreign_key: true
      t.references :user, foreign_key: true
      t.string :status, default: "Opened"
      t.timestamps
    end
  end
end
