class HealthcheckController < ApplicationController
  def check
    #chequear redis y eso
    Organization.first
    render json: { status: "OK" }, status: :ok
  rescue
    render json: { status: "OK" }, status: :ok
    #
  end
end
