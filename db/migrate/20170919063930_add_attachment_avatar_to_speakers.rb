class AddAttachmentAvatarToSpeakers < ActiveRecord::Migration[5.1]
  def self.up
    change_table :speakers do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :speakers, :avatar
  end
end
