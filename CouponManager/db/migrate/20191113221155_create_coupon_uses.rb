class CreateCouponUses < ActiveRecord::Migration[6.0]
  def change
    create_table :coupon_uses do |t|
      t.integer :coupon_code
      t.integer :remaining_uses
      t.datetime :valid_limit
    end
  end
end
