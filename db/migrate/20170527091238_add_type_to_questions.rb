class AddTypeToQuestions < ActiveRecord::Migration
  def up
    add_column :questions, :question_type, :string, :default => 'textarea'
  end
  def down
    remove_column :questions, :question_type    
  end
end
