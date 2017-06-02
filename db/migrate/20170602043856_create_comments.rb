class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.references :slam
      t.references :user
      t.string :comment
      t.integer :reply_to, :class => 'Comment' 
      t.timestamps null: false
    end
  end
  def down
    drop_table :comments
  end

end
