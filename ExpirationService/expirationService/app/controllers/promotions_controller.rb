class PromotionsController < ApplicationController
  skip_before_action :verify_authenticity_token
    def index
      @promotions = Promotion.all
    end

    def addPromotion
      promotionExpiration = request.headers['expiration']
      promotionName = request.headers['name']
      Promotion.create(name: promotionName, expiration: promotionExpiration)
      render json: { status: promotionName }, status: :ok

    end




  end