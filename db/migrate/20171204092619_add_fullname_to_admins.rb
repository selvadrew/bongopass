class AddFullnameToAdmins < ActiveRecord::Migration[5.1]
  def change
    add_column :admins, :fullname, :string
  end
end
