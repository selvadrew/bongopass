class RenameEventIdToTicketId < ActiveRecord::Migration[5.1]
  def change
  	rename_column :orders, :event_id, :ticket_id
  end
end
