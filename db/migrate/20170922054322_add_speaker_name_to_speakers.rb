class AddSpeakerNameToSpeakers < ActiveRecord::Migration[5.1]
  def change
    add_column :speakers, :speaker_name, :string
  end
end
