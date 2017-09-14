class AddRewardsUsedToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :rewards_used, :decimal
  end
end
