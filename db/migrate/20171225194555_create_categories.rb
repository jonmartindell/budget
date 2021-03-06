class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :heading
      t.integer :budget
      t.boolean :infrequent
      t.boolean :expense

      t.timestamps null: false
    end
  end
end
