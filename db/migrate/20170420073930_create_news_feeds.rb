class CreateNewsFeeds < ActiveRecord::Migration
  def up
    create_table :news_feeds do |t|
      t.references :user
      t.string :action
      t.references :book
      t.references :slam
      t.timestamps null: false
    end
  end
  def down
    drop_table :news_feeds
  end 
end
