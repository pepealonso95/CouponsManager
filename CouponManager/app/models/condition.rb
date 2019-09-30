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

    def generatePrimitiveCondition(comparator, attribute, value)
        @is_primitive = true
        @comparator = comparator
        @attribute = attribute
        @value = value
    end

    def generateNestedCondition(operator, c1, c2)
        @is_primitive = false
        @operator = operator
        @condition1 = c1
        @condition2 = c2
    end

    def getResult(total, quantity, product_size)
        @declarationArray = {Constants::TOTAL => total, Constants::QUANTITY => quantity, Constants::PRODUCT_SIZE => product_size}
        if (@is_primitive)
            getComparisonResult(@comparator, @declarationArray[@attribute], @value)
        else
            getConditionResult(@operator, @condition1.getResult(total, quantity, product_size), @condition2.getResult(total, quantity, product_size))
        end
    end

    def getConditionResult(operator, leftComparison, rightComparison)
        case operator
        when Constants::AND
            leftComparison && rightComparison
        when Constants::OR
            leftComparison || rightComparison
        end
    end 

    def getComparisonResult(comparator, leftValue, rightValue)
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