class DropConditions < ActiveRecord::Migration[6.0]
  def up
    drop_table :conditions
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
