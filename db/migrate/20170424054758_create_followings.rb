class CreateFollowings < ActiveRecord::Migration
  def change
    create_table :followings do |t|
      t.references :user
      t.references :follower, :class => 'User'
      t.timestamps null: false
    end
  end
end
