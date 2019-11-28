# frozen_string_literal: true

class CreatePromotions < ActiveRecord::Migration[6.0]
  def change
    create_table :promotions do |t|
      t.string :name
      t.boolean :active
      t.integer :coupon_code
      t.integer :type
      t.integer :return_value
      t.boolean :is_percentage

      t.timestamps
    end
  end
end
