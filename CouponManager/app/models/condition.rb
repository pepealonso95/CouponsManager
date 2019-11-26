# frozen_string_literal: true

class Condition
  module Constants

    LESS_EQ = 'LESS_EQ'
    LESS = 'LESS'
    EQUALS = 'EQUALS'
    NOT_EQUALS = 'NOT_EQUALS'
    GREAT = 'GREAT'
    GREAT_EQ = 'GREAT_EQ'

    AND = 'AND'
    OR = 'OR'
  end

  def self.getResult(condition, conditions)
    if condition['is_primitive']
      if conditions[condition['attribute'].downcase].nil?
        false
      else
        if conditions[condition['attribute'].downcase].class == condition['value'].class
          getComparisonResult(condition['comparator'], conditions[condition['attribute'].downcase], condition['value'])
        else
          false
        end
      end
    else
      getConditionResult(condition['operator'], getResult(condition['condition1'], conditions), getResult(condition['condition2'], conditions))
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
    else
      false
    end
  end
end
