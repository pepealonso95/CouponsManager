class CreateCouponUse < ActiveRecord::Migration[6.0]
  def change
    create_table :coupon_use do |t|
      t.integer :coupon_code
      t.integer :remaining_uses
      t.datetime :valid_limit
    end
  end
end
