# frozen_string_literal: true

class AddNotNullToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :email, :string, null: true
    change_column :users, :password, :string, null: true
    change_column :users, :lastname, :string, null: true
    change_column :users, :name, :string, null: true
  end
end
