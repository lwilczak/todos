class AddPriorityToTodo < ActiveRecord::Migration
  def self.up
     add_column :todos, :priority_id, :integer
     add_index :todos, :priority_id
  end

  def self.down
    remove_column :todos, :priority_id
  end
end
