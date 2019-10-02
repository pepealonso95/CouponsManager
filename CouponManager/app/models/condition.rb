class Condition

    # include Ruby::Enum

    module Constants
        TOTAL = "TOTAL"
        QUANTITY = "QUANTITY"
        PRODUCT_SIZE = "PRODUCT_SIZE"

        LESS_EQ = "LESS_EQ"
        LESS = "LESS"
        EQUALS = "EQUALS"
        NOT_EQUALS = "NOT_EQUALS"
        GREAT = "GREAT"
        GREAT_EQ = "GREAT_EQ"

        AND = "AND"
        OR = "OR"
    end

    # def initialize(stringCondition)
    #     require 'json'
    #     condition = JSON.parse(stringCondition)
    #     sortCondition(condition)
    # end

    # def sortCondition(condition)
    #     if (condition["is_primitive"])
    #         generatePrimitiveCondition(condition["comparator"], condition["attribute"], condition["value"])
    #     else
    #         generateNestedCondition(condition["operator"], condition["condition1"], condition["condition2"])
    #     end
    # end

    # def generatePrimitiveCondition(comparator, attribute, value)
    #     @is_primitive = true
    #     @comparator = comparator
    #     @attribute = attribute
    #     @value = value
    # end

    # def generateNestedCondition(operator, c1, c2)
    #     @is_primitive = false
    #     @operator = operator
    #     @condition1 = sortCondition(c1)
    #     @condition2 = sortCondition(c2)
    # end

    def self.getResult(condition, total, quantity, product_size)
        declarationArray = {Constants::TOTAL => total, Constants::QUANTITY => quantity, Constants::PRODUCT_SIZE => product_size}
        if (condition["is_primitive"])
            self.getComparisonResult(condition["comparator"], declarationArray[condition["attribute"]], condition["value"])
        else
            self.getConditionResult(condition["operator"], getResult(condition["condition1"], total, quantity, product_size), getResult(condition["condition2"], total, quantity, product_size))
        end
    end

    def self.getConditionResult(operator, leftComparison, rightComparison)
        case operator
        when Constants::AND
            leftComparison and rightComparison
        when Constants::OR
            leftComparison or rightComparison   
        end
    end 

    def self.getComparisonResult(comparator, leftValue, rightValue)
        case comparator
        when Constants::LESS_EQ
            leftValue <= rightValue
        when Constants::LESS
            leftValue < rightValue
        when Constants::EQUALS
            leftValue == rightValue
        when Constants::NOT_EQUALS
            leftValue != rightValue
        when Constants::GREAT
            leftValue > rightValue
        when Constants::GREAT_EQ
            leftValue >= rightValue
        end
    end
end