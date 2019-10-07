class AddTotalResponseTimeToPromotions < ActiveRecord::Migration[6.0]
  def change
    add_column :promotions, :total_response_time, :integer
  end
end
