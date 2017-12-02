class AddFirstNameToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :first_name, :string
  end
end
