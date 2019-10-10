# frozen_string_literal: true

class AddAvatarToUser < ActiveRecord::Migration[6.0]
  def up
    add_attachment :users, :avatar
  end

  def down
    remove_attachment :users, :avatar
  end
  end
