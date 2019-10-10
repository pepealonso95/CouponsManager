# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.belongs_to :promotion, null: false, foreign_key: true

      t.timestamps
    end
  end
end
