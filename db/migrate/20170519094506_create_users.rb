class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.bigint :uid
      t.string :first_name,         null:false
      t.string :last_name,          null:false
      t.text :description
      t.integer :age
      t.string :gender
      t.string :city
      t.string :college
      t.text :address                           
      t.string :email,              null: false
      t.string :avatar
      t.string :provider
      t.string :oauth_token
      t.datetime :oauth_expires_at
      t.timestamps null: false
    end
    
    add_index :users, :id
    add_index :users, :email  
  end
  def down
    drop_table :users
  end
end
