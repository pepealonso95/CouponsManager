# frozen_string_literal: true

class ChangeTransactionColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :transactions, :transaction, :transaction_code
  end
end
