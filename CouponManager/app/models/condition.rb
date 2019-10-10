# frozen_string_literal: true

class Condition
  module Constants
    TOTAL = 'TOTAL'
    QUANTITY_PRODUCT_SIZE = 'QUANTITY_PRODUCT_SIZE'

    LESS_EQ = 'LESS_EQ'
    LESS = 'LESS'
    EQUALS = 'EQUALS'
    NOT_EQUALS = 'NOT_EQUALS'
    GREAT = 'GREAT'
    GREAT_EQ = 'GREAT_EQ'

    AND = 'AND'
    OR = 'OR'
  end

  def self.getResult(condition, total, quantity_product_size)
    declarationArray = { Constants::TOTAL => total, Constants::QUANTITY_PRODUCT_SIZE => quantity_product_size }
    if condition['is_primitive']
      getComparisonResult(condition['comparator'], declarationArray[condition['attribute']], condition['value'])
    else
      getConditionResult(condition['operator'], getResult(condition['condition1'], total, quantity_product_size), getResult(condition['condition2'], total, quantity_product_size))
    end
  end

  def self.getConditionResult(operator, leftComparison, rightComparison)
    case operator
    when Constants::AND
      leftComparison && rightComparison
    when Constants::OR
      leftComparison || rightComparison
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
