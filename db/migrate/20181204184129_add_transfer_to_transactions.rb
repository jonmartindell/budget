class AddTransferToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :transfer, :boolean
  end
end
