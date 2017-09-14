class AddOrganizerSalesToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :organizer_sales, :decimal
  end
end
