class ChangeRemainingNAme < ActiveRecord::Migration[6.0]
  def change
      rename_column :coupon_use, :reamaining_uses, :remaining_uses
  end
end
