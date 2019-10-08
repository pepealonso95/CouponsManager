class Promotion < ApplicationRecord
    belongs_to :organization
    has_many :transactions
end
