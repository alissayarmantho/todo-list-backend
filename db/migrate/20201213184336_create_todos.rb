class CreateTodos < ActiveRecord::Migration[6.1]
  def change
    create_table :todos do |t|
      t.uuid :id
      t.text :content

      t.timestamps
    end
  end
end
