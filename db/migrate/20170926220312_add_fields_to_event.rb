class AddFieldsToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :latitude, :float
    add_column :events, :longitude, :float
  end
end
