require 'test_helper'

class ConditionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get conditions_new_url
    assert_response :success
  end

  test "should get create" do
    get conditions_create_url
    assert_response :success
  end

  test "should get update" do
    get conditions_update_url
    assert_response :success
  end

  test "should get edit" do
    get conditions_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get conditions_destroy_url
    assert_response :success
  end

end
