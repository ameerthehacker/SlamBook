class CreateQuestionOptions < ActiveRecord::Migration
  def up
    create_table :question_options do |t|
      t.references :question
      t.string :option
      t.timestamps null: false
    end
  end
  def down
    drop_table :question_options
  end
end
