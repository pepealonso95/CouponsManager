# frozen_string_literal: true

class HealthcheckController < ApplicationController
  def check
    # chequear redis y eso
    Organization.first
    render json: { status: 'OK' }, status: :ok
  rescue StandardError
    render json: { status: 'OK' }, status: :ok
  end
end
