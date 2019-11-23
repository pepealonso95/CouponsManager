class CouponUseToUserUSe < ActiveRecord::Migration[6.0]
  def change
    remove_reference :user_coupon_codes, :coupon_uses, index: true, foreign_key: true
    add_reference :user_coupon_codes, :coupon_use, foreign_key: true
  end
end
