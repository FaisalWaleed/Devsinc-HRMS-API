class CreateTicketStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :ticket_statuses do |t|
      t.references :ticket, foreign_key: true
      t.string :status
      t.boolean :active

      t.timestamps
    end
  end
end
