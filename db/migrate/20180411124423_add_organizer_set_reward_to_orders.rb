class AddOrganizerSetRewardToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :organizer_set_reward, :integer
  end
end
