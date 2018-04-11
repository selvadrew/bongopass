class AddRewardFeeToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :reward_fee, :integer
  end
end
