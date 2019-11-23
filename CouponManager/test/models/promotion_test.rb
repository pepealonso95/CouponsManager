# frozen_string_literal: true

require 'test_helper'

class PromotionTest < ActiveSupport::TestCase

  test 'promotion without name' do
    promotion = Promotion.new(
      active: 'true',
      coupon_code: '2',
      is_percentage: 'true',
      promotion_type: '0',
      created_at: DateTime.current,
      updated_at: DateTime.current,
      condition: '{"is_primitive":true,"attribute":"TOTAL","comparator":"GREAT","value":0}',
      return_value: '23',
      organization_id: '1'
    )
  assert_not promotion.valid?
  end

  test 'promotion with empty name' do
    promotion = Promotion.new(
      name: '',
      active: 'true',
      coupon_code: '2',
      is_percentage: 'true',
      promotion_type: '0',
      created_at: DateTime.current,
      updated_at: DateTime.current,
      condition: '{"is_primitive":true,"attribute":"TOTAL","comparator":"GREAT","value":0}',
      return_value: '23',
      organization_id: '1'
    )
  assert_not promotion.valid?
  end

  test 'promotion without active' do
    promotion = Promotion.new(
      name: 'some promotion',
      coupon_code: '2',
      is_percentage: 'true',
      promotion_type: '0',
      created_at: DateTime.current,
      updated_at: DateTime.current,
      condition: '{"is_primitive":true,"attribute":"TOTAL","comparator":"GREAT","value":0}',
      return_value: '23',
      organization_id: '1'
    )
  assert_not promotion.valid?
  end

  test 'promotion without coupon code' do
    promotion = Promotion.new(
      name: 'some promotion',
      active: 'true',
      is_percentage: 'true',
      promotion_type: '0',
      created_at: DateTime.current,
      updated_at: DateTime.current,
      condition: '{"is_primitive":true,"attribute":"TOTAL","comparator":"GREAT","value":0}',
      return_value: '23',
      organization_id: '1'
    )
  assert_not promotion.valid?
  end


  test 'promotion with empty code' do
    promotion = Promotion.new(
      name: 'some promotion',
      active: 'true',
      coupon_code: '',
      is_percentage: 'true',
      promotion_type: '0',
      created_at: DateTime.current,
      updated_at: DateTime.current,
      condition: '{"is_primitive":true,"attribute":"TOTAL","comparator":"GREAT","value":0}',
      return_value: '23',
      organization_id: '1'
    )
  assert_not promotion.valid?
  end

  test 'promotion with empty condition' do
    promotion = Promotion.new(
      name: 'some promotion',
      active: 'true',
      coupon_code: '2',
      is_percentage: 'true',
      promotion_type: '0',
      created_at: DateTime.current,
      updated_at: DateTime.current,
      condition: '',
      return_value: '23',
      organization_id: '1'
    )
  assert_not promotion.valid?
  end

  test 'promotion without percentage' do
    promotion = Promotion.new(
      name: 'some promotion',
      active: 'true',
      coupon_code: '2',
      is_percentage: 'true',
      promotion_type: '0',
      created_at: DateTime.current,
      updated_at: DateTime.current,
      condition: '{"is_primitive":true,"attribute":"TOTAL","comparator":"GREAT","value":0}',
      return_value: '23',
      organization_id: '1'
    )
  assert_not promotion.valid?
  end

  test 'promotion without created_at' do
    promotion = Promotion.new(
      name: 'some promotion',
      active: 'true',
      coupon_code: '2',
      is_percentage: 'true',
      promotion_type: '0',
      updated_at: DateTime.current,
      condition: '{"is_primitive":true,"attribute":"TOTAL","comparator":"GREAT","value":0}',
      return_value: '23',
      organization_id: '1'
    )
  assert_not promotion.valid?
  end

  test 'promotion without updated_at' do
    promotion = Promotion.new(
      name: 'some promotion',
      active: 'true',
      coupon_code: '2',
      is_percentage: 'true',
      promotion_type: '0',
      created_at: DateTime.current,
      condition: '{"is_primitive":true,"attribute":"TOTAL","comparator":"GREAT","value":0}',
      return_value: '23',
      organization_id: '1'
    )
  assert_not promotion.valid?
  end

  test 'promotion without condition' do
    promotion = Promotion.new(
      name: 'some promotion',
      active: 'true',
      coupon_code: '2',
      is_percentage: 'true',
      promotion_type: '0',
      created_at: DateTime.current,
      updated_at: DateTime.current,
      condition: '{"is_primitive":true,"attribute":"TOTAL","comparator":"GREAT","value":0}',
      return_value: '23',
      organization_id: '1'
    )
  assert_not promotion.valid?
  end

  test 'promotion without return_value' do
    promotion = Promotion.new(
      name: 'some promotion',
      active: 'true',
      coupon_code: '2',
      is_percentage: 'true',
      promotion_type: '0',
      created_at: DateTime.current,
      updated_at: DateTime.current,
      condition: '{"is_primitive":true,"attribute":"TOTAL","comparator":"GREAT","value":0}',
      return_value: '23',
      organization_id: '1'
    )
  assert_not promotion.valid?
  end

  test 'promotion without organization_id' do
    promotion = Promotion.new(
      name: 'some promotion',
      active: 'true',
      coupon_code: '2',
      is_percentage: 'true',
      promotion_type: '0',
      created_at: DateTime.current,
      updated_at: DateTime.current,
      condition: '{"is_primitive":true,"attribute":"TOTAL","comparator":"GREAT","value":0}',
      return_value: '23',
    )
  assert_not promotion.valid?
  end




end
