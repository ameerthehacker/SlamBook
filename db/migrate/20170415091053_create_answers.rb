class CreateAnswers < ActiveRecord::Migration
  def up
    create_table :answers do |t|
      t.references :slam
      t.string :question
      t.text :answer
      t.timestamps null: false
    end
  end
  def down
    drop_table :answers
  end
end
