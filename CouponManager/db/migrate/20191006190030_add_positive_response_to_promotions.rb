# frozen_string_literal: true

class AddPositiveResponseToPromotions < ActiveRecord::Migration[6.0]
  def change
    add_column :promotions, :positive_response, :integer
  end
end
