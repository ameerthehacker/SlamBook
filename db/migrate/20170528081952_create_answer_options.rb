class CreateAnswerOptions < ActiveRecord::Migration
  def up
    create_table :answer_options do |t|
      t.references :answer
      t.string :option
      t.timestamps null: false
    end
  end
  def down
    drop_table :answer_options
  end
end
