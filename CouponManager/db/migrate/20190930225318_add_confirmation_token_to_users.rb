# frozen_string_literal: true

class AddConfirmationTokenToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :confirmation_token, :string
  end
end
