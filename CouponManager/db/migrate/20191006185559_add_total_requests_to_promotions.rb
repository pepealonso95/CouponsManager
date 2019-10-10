# frozen_string_literal: true

class AddTotalRequestsToPromotions < ActiveRecord::Migration[6.0]
  def change
    add_column :promotions, :total_requests, :integer
  end
end
