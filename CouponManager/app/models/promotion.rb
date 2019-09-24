class Promotion < ApplicationRecord
    belongs_to :condition, optional: true 
end
