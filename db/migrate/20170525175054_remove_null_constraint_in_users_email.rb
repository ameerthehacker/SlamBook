class RemoveNullConstraintInUsersEmail < ActiveRecord::Migration
  def up
    change_column_null :users, :email, true
    change_column_null :users, :last_name, true
  end
  def down
    change_column_null :users, :email, false
    change_column_null :users, :last_name, false
  end
end
