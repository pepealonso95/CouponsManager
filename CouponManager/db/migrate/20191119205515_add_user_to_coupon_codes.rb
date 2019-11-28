class AddUserToCouponCodes < ActiveRecord::Migration[6.0]
  def change
    add_reference :user_coupon_codes, :coupon_use, foreign_key: true
  end
end
