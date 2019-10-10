# frozen_string_literal: true

require 'test_helper'

class PromotionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get promotions_new_url
    assert_response :success
  end

  test 'should get create' do
    get promotions_create_url
    assert_response :success
  end

  test 'should get update' do
    get promotions_update_url
    assert_response :success
  end

  test 'should get edit' do
    get promotions_edit_url
    assert_response :success
  end

  test 'should get destroy' do
    get promotions_destroy_url
    assert_response :success
  end
end
