class AddReferralIdToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :referral_id, :integer
  end
end
