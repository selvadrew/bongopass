class AddBongoFeeToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :bongo_fee, :decimal
  end
end
