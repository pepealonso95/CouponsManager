class AddPromotionToCouponUses < ActiveRecord::Migration[6.0]
  def change
    add_reference :coupon_uses, :promotion, null: false, foreign_key: true
  end
end
