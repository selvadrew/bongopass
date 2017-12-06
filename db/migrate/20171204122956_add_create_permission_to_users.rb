class AddCreatePermissionToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :create_permission, :string
  end
end
