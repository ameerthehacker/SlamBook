class CreateSlams < ActiveRecord::Migration
  def up
    create_table :slams do |t|
      t.references :user
      t.references :book
      t.string :privacy, :default => 'PRIVATE'
      t.string :status, :default => 'NOT_READ'
      t.timestamps null: false
    end
  end
  def down
    drop_table :slams
  end
end
