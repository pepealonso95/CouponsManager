class RemoveCodeFromPromotions < ActiveRecord::Migration[6.0]
  def change
    remove_column :promotions, :coupon_code
    add_column :promotions, :limit_time, :datetime
  end
end
