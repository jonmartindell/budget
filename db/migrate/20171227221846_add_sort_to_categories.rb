class AddSortToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :sort, :decimal
  end
end
