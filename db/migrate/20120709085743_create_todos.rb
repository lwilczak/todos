class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :subject
      t.text :content

      t.timestamps
    end
  end
end
