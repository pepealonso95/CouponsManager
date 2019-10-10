# frozen_string_literal: true

class AddNegativeResponseToPromotions < ActiveRecord::Migration[6.0]
  def change
    add_column :promotions, :negative_response, :integer
  end
end
