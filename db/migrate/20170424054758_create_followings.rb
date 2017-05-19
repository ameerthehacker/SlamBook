class CreateFollowings < ActiveRecord::Migration
  def up
    create_table :followings do |t|
      t.references :user
      t.references :follower, :class => 'User'
      t.timestamps null: false
    end
  end
  def down
    drop_table :followings
  end
end
