# frozen_string_literal: true
require 'rest-client'
require 'jwt'
require 'json'
class PromotionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:testToken, :evaluate]
  skip_before_action :authenticate_user!, only: [:evaluate, :testToken, :report_rest]
  before_action :is_admin? , only: [:new, :create, :destroy, :edit, :update, :authorizationCodes, :getCode, :viewReport]

  def new
    logger.info 'new promotion'
    logger.info ENV['GMAIL_USERNAME']
    @promotion = Promotion.new
  end

  def show
    logger.info 'new promotion shown'
    @promotion = cached_promotion
  end

  def cached_promotion
    Rails.cache.fetch("promotion-#{promotion_id}", expires_in: 10.minutes) do
      Promotion.find(promotion_id)
    end
  end

  def viewReport()
    response = RestClient.get 'https://coupon-reports-service.herokuapp.com/reports'
    if response.code == 200
        @report = response
        render :demographicReport
    else
        raise "An error has occured. Response was #{response.code}"
    end
  end

  def report
    @promotion = cached_promotion
    @average = @promotion.total_requests!=0 ? (@promotion.total_response_time / @promotion.total_requests) : 0
    @rate = "#{@promotion.positive_response}/#{@promotion.negative_response}"
  end

  def report_rest
    token = request.headers['token']
    payload = JWT.decode token, nil, false
    contains = payload[0]['promotions'].include? promotion_id.to_s
    if contains
      @promotion = cached_promotion
      @average = @promotion.total_requests!=0 ? (@promotion.total_response_time / @promotion.total_requests) : 0
      @rate = "#{@promotion.positive_response}/#{@promotion.negative_response}"
      render json: { name: @promotion.name, invocations: @promotion.total_requests, positive_rate: @rate, average_time: @average }, status: :ok
    else
      render json: 'unauthorized', status: :unauthorized
    end
  rescue StandardError
    render json: 'internal server error', status: :error
  end

  def create
    @promotion = Promotion.new(promotion_params)
    
    RestClient.post 'https://couponmanager-expiration-date.herokuapp.com/promotions/addPromotion', { }.to_json, {content_type: :json, accept: :json, name: @promotion.name, expiration: @promotion.limit_time}
    redirect_to promotions_path if @promotion.save
  end

  def update
    @promotion = cached_promotion
    if @promotion.update(edit_promotion_params)
      Rails.cache.delete("promotion-#{promotion_id}")
      redirect_to promotions_path
    else
      render :edit
    end
  end

  def edit
    @promotion = cached_promotion
  end

  def destroy
    @promotion = cached_promotion
    if @promotion.update(active: false)
      Rails.cache.delete("transaction-#{params["transaction_id"]}-#{promotion_id}")
      redirect_to promotions_path
    end
  end

  def cached_transaction
    Rails.cache.fetch("transaction-#{params["transaction_id"]}-#{promotion_id}", expires_in: 12.hours) do
      @promotion.transactions.exists?(transaction_code: params["transaction_id"])
    end
  end

  def evaluate
    @result = "promocion invalida"
    @coupon_use = nil
    token = request.headers['token']
    payload = JWT.decode token, nil, false
    contains = payload[0]['promotions'].include? promotion_id.to_s
    if contains
      start_time = Time.now
      @promotion = cached_promotion
      if @promotion.active
        valid = false
        if @promotion.promotion_type == 0
          transaction = cached_transaction
          unless transaction
            valid = true
            Rails.cache.delete("transaction-#{params["transaction_id"]}-#{promotion_id}")
          end
        elsif @promotion.promotion_type == 1
          @coupon_uses = CouponUse.where(coupon_code: params["coupon_code"], promotion_id: @promotion.id)
          @coupon_use = @coupon_uses.first   
          if(@coupon_use!=nil && @coupon_use.remaining_uses > 0 && @coupon_use.valid_limit > DateTime.now)
            @user_coupon_code = UserCouponCode.where(coupon_use_id: @coupon_use.id, user_id: params["user_id"]).first
            if (@user_coupon_code==nil)
              valid = true
            end
          elsif (@coupon_use!=nil && @coupon_use.remaining_uses == 0)
            @result = "el cupon supero el limite de usos"
          elsif (@coupon_use!=nil && @coupon_use.valid_limit < DateTime.now)
            @result = "el cupon expiro"
          end
        end
        if @promotion.limit_time < DateTime.now
          valid = false
          @result = "promocion expiro"
        end
        if valid
          require 'json'
          condition = JSON.parse(@promotion.condition)
          applies = Condition.getResult(condition, params)
          if applies
            if @promotion.is_percentage
              @result = params["total"] - params["total"] * (@promotion.return_value / 100)
              totalSpentAdd = @result
            else
              @result = @promotion.return_value
            end
              RestClient.post 'https://coupon-reports-service.herokuapp.com/reports', 
              {"promotionId"=>promotion_id.to_i, 
              "iata_code"=> (params["iata_code"]!=nil ? params["iata_code"] : ""), 
              "iso_code"=> (params["iso_code"]!=nil ? params["iso_code"] : ""),
               "birthdate"=> (params["birthdate"]!=nil ? params["birthdate"] : "") }.to_json, {content_type: :json, accept: :json}
            positiveAdd = 1
            if @promotion.promotion_type == 0
              @transaction = Transaction.new(transaction_code: params["transaction_id"], promotion_id: promotion_id)
              @transaction.save
            else
              @coupon_use.update_attributes(remaining_uses: @coupon_use.remaining_uses-1)
              @user_coupon_code = UserCouponCode.new(coupon_use_id: @coupon_use.id, user_id: params["user_id"])
              @user_coupon_code.save
            end
          else
            negativeAdd = 1
            @result = "promocion no aplica"
          end
        else
          negativeAdd = 1
        end
        total_time = Time.now - start_time
        @promotion.update_attributes(total_requests: @promotion.total_requests + 1,
                                     total_response_time: @promotion.total_response_time + (total_time * 1000),
                                     positive_response: @promotion.positive_response + positiveAdd.to_i,
                                     total_spent: @promotion.total_spent + totalSpentAdd.to_i,
                                     negative_response: @promotion.negative_response + negativeAdd.to_i)
        Rails.cache.delete("promotion-#{promotion_id}")
        cached_promotion
        render json: @result, status: :ok
      else
        render json: false, status: :ok
      end
    else
      render json: 'unauthorized', status: :unauthorized
    end
  rescue StandardError
    render json: 'internal server error', status: :error
  end

  def authorizationCodes
    @promotions = Promotion.all
    render :authorizationCodes
  end

  def getCode
    promotionIds = params[:promotions]
    payload = { promotions: promotionIds }
    # IMPORTANT: set nil as password parameter
    token = JWT.encode payload, nil, 'none'
    redirect_to controller: 'promotions', id: token, action: 'viewCode'

    # render json: { status: token}, status: :ok
  end

  def testToken
    token = request.headers['token']
    payload = JWT.decode token, nil, false
    contains = payload[0]['promotions'].include? '38'
    render json: { status: contains }, status: :ok
  end

  def viewCode
    @token = params[:id]
    render :viewCode
  end

  def viewImage
    @user = current_user
    render :viewImage
  end

  # def testPromotion
  #   @promotion = Promotion.find(5)
  #   @result = Condition.new(@promotion.condition)
  #   @result = @condition.getResult(30,300,400)
  #   render :create
  # end


  def index
    @promotions = Promotion.where(organization_id: current_user.organization_id)
    @promotions = @promotions.where(name: name) if name && name != ''
    if coupon_code && coupon_code != ''
      @coupon_use = CouponUse.where(coupon_code: coupon_code)
      if @coupon_use.empty?
        @promotions  = []
      else
        @promotions = @promotions.where(id: @coupon_use.first.id)
      end
    end
    @promotions = @promotions.where(active: active) if active && active != ''
    if promotion_type && promotion_type != ''
      @promotions = @promotions.where(promotion_type: promotion_type)
    end
  end

  def promotion_params
    params.require(:promotion).permit(:name, :condition, :active, :promotion_type, :return_value, :is_percentage, :organization_id, :limit_time)
  end


  def edit_promotion_params
    params.require(:promotion).permit(:name, :condition, :active, :promotion_type, :return_value, :is_percentage, :organization_id, :limit_time)
  end

  def promotion_id
    params.require(:id)
  end

  def coupon_code
    params.permit(:coupon_code)['coupon_code']
  end

  def name
    params.permit(:name)['name']
  end

  def active
    params.permit(:active)['active']
  end

  def promotion_type
    params.permit(:promotion_type)['promotion_type']
  end

end
