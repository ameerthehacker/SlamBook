class AddTypeToAnswers < ActiveRecord::Migration
  def up
    add_column :answers, :answer_type, :string, :default => 'textarea'
  end
  def down
    remove_column :answers, :answer_type    
  end
end
