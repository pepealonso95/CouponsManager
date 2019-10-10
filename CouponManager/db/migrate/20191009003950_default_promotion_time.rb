# frozen_string_literal: true

class DefaultPromotionTime < ActiveRecord::Migration[6.0]
  def change
    change_column :promotions, :return_value, :integer, default: 0
    change_column :promotions, :total_requests, :integer, default: 0
    change_column :promotions, :total_response_time, :integer, default: 0
    change_column :promotions, :positive_response, :integer, default: 0
    change_column :promotions, :negative_response, :integer, default: 0
    add_column :promotions, :total_spent, :integer, default: 0
  end
end
