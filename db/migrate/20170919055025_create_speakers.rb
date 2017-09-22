class CreateSpeakers < ActiveRecord::Migration[5.1]
  def change
    create_table :speakers do |t|
      t.references :event, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
