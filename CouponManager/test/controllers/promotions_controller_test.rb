# frozen_string_literal: true

require 'test_helper'

class PromotionsControllerTest < ActionDispatch::IntegrationTest

  setup do
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url
  end  

  test 'should get new' do
    get promotions_new_url
    assert_response :success
  end

  test 'should get edit' do
    get "/promotions/1/edit"
    assert_response :success
  end

  test 'should get destroy' do
    get "/promotions/1"
    assert_response :success
  end

  test 'should get report' do
    get "/promotions/report?id=1"
    assert_response :success
end

  # test 'should get evaluate' do
  #   get "/promotions/evaluate?id=1&total=1&quantity_product_size=1&transaction_id=1&coupon_code=1"
  #   assert_response :error
  # end

  test 'should auth code' do
    get "/promotions/authorizationCodes"
    assert_response :success
  end

  test 'should get code' do
    get ""
    assert_response :success
  end

  test 'should get image' do
    get "/promotions/viewImage"
    assert_response :success
  end

end
