class CreateUserCouponCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :user_coupon_codes do |t|
      
      t.timestamps
    end
  end
end
