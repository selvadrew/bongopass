class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :event_title
      t.string :location
      t.date :start_date
      t.time :start_time
      t.date :end_date
      t.time :end_time
      t.text :event_description
      t.string :organizer_name
      t.text :organizer_description
      t.string :event_type
      t.string :facebook_link
      t.string :twitter_link
      t.string :instagram_link
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
