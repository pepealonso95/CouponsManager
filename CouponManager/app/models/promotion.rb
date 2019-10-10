# frozen_string_literal: true

class Promotion < ApplicationRecord
  belongs_to :organization
  has_many :transactions
end
