# frozen_string_literal: true

class AddTransactionToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :transaction, :string
  end
end
