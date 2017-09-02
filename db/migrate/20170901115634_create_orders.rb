class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :address
      t.string :city
      t.string :province

      t.timestamps
    end
  end
end
