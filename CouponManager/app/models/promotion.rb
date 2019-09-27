class Promotion < ApplicationRecord
    has_one :condition, optional: true 
end
