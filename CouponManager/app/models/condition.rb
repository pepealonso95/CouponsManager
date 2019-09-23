class Condition < ApplicationRecord
    belongs_to :condition1, class_name : "Condition", optional: true
    belongs_to :condition2, class_name : "Condition", optional: true
    has_one: promotion 
end