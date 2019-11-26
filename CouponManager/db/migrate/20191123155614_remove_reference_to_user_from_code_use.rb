class RemoveReferenceToUserFromCodeUse < ActiveRecord::Migration[6.0]
  def change
    remove_reference :user_coupon_codes, :user, index: true, foreign_key: true
    add_column :user_coupon_codes, :user_id, :bigint
  end
end
