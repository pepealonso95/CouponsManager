# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :lastname
      t.string :email
      t.integer :role
      t.string :password
      t.string :photo_url

      t.timestamps
    end
  end
end
