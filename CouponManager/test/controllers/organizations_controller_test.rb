# frozen_string_literal: true

require 'test_helper'

class OrganizationsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get organizations_new_url
    assert_response :success
  end

  test 'should get create' do
    get organizations_create_url
    assert_response :success
  end

  test 'should get update' do
    get organizations_update_url
    assert_response :success
  end

  test 'should get edit' do
    get organizations_edit_url
    assert_response :success
  end

  test 'should get destroy' do
    get organizations_destroy_url
    assert_response :success
  end
end
