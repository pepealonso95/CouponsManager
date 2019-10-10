# frozen_string_literal: true

class AddConditionToPromotions < ActiveRecord::Migration[6.0]
  def change
    add_column :promotions, :condition, :string
  end
end
