class AddRewardFeeToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :reward_fee, :integer
  end
end
