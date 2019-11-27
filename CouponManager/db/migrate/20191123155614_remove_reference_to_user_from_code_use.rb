class RemoveReferenceToUserFromCodeUse < ActiveRecord::Migration[6.0]
  def changess
    add_column :user_coupon_codes, :user_id, :bigint
  end
end
