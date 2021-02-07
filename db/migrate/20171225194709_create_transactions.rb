class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :category, index: true, foreign_key: true
      t.string :note
      t.string :merchant
      t.decimal :amount
      t.date :date

      t.timestamps null: false
    end
  end
end
