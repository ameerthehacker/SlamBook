class CreateQuestions < ActiveRecord::Migration
  def up
    create_table :questions do |t|
      t.string :question
      t.references :book
      t.timestamps null: false
    end
  end
  def down
    drop_table :questions
  end
end
