# frozen_string_literal: true

require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  
  test 'valid organization' do
    organization = Organization.new(
      name: 'Some title',
      created_at: DateTime.current,
      updated_at: DateTime.current,
    )
  assert organization.valid?
  end

  test 'organization without created time' do
    organization = Organization.new(
      name: 'Some title',
      updated_at: DateTime.current,
    )
  assert organization.valid?
  end

  test 'organization without updated time' do
    organization = Organization.new(
      name: 'Some title',
      created_at: DateTime.current,
    )
  assert organization.valid?
  end







end
