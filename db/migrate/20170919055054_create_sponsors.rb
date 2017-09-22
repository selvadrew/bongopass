class CreateSponsors < ActiveRecord::Migration[5.1]
  def change
    create_table :sponsors do |t|
      t.references :event, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
