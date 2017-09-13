class CreateReferrals < ActiveRecord::Migration[5.1]
  def change
    create_table :referrals do |t|
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
