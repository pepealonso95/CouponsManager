# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:valid)
  end

  test 'valid user' do
    assert @user.save
  end

  test 'invalid without email' do
    @user.email = nil
    assert_not @user.save
  end

  test 'valid without role' do
    @user.role = nil
    assert @user.save
  end
  test 'valid without lastname' do
    @user.lastname = nil
    assert @user.save
  end
  test 'valid without password' do
    @user.password = nil
    assert @user.save
  end
  test 'valid without photo_url' do
    @user.photo_url = nil
    assert @user.save
  end
end
