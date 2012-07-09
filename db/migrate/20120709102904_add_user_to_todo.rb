class AddUserToTodo < ActiveRecord::Migration
  def self.up
     add_column :todos, :user_id, :integer
     add_index :todos, :user_id
  end

  def self.down
    remove_column :todos, :user_id
  end
end
