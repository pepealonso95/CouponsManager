class RemoveReferenceToUserFromCodeUse < ActiveRecord::Migration[6.0]
  def change
    add_column :user_coupon_codes, :user_id, :bigint
  end
end
