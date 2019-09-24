class CreateConditions < ActiveRecord::Migration[6.0]
  def change
    create_table :conditions do |t|
      t.integer :is_primitive
      t.integer :operator
      t.integer :comparator
      t.integer :attribute
      t.integer :value

      t.timestamps
    end
  end
end
