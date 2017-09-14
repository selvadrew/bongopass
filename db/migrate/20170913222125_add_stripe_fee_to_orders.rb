class AddStripeFeeToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :stripe_fee, :decimal
  end
end
