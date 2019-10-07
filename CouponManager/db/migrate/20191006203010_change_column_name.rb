class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :promotions, :type, :promotion_type
  end
end
