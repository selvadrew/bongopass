class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.string :ticket_type
      t.string :ticket_name
      t.integer :ticket_quantity
      t.decimal :ticket_price
      t.string :ticket_description
      t.date :ticket_start_date
      t.time :ticket_start_time
      t.date :ticket_end_date
      t.time :ticket_end_time
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
