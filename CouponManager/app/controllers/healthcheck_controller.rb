# frozen_string_literal: true
require 'redis'

class HealthcheckController < ApplicationController
  def check
    Organization.first
    redisStatus = check_redis
    postgresStatus = check_postgres
    render json: { redisStatus: redisStatus, postgresStatus: postgresStatus }, status: :ok
  end

  def check_redis
    redis = Redis.new(url: ENV['REDIS_URL'])
    redis.ping == 'PONG' rescue false
  end

  def check_postgres
    ::ActiveRecord::Base.connection.verify!
    true
  rescue StandardError
    false
  end
end
