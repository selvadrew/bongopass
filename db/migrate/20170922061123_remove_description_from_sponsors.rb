class RemoveDescriptionFromSponsors < ActiveRecord::Migration[5.1]
  def change
    remove_column :sponsors, :description, :string
  end
end
