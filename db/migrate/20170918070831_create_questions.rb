class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.references :event, foreign_key: true
      t.string :registration_question
      t.integer :question_type

      t.timestamps
    end
  end
end
