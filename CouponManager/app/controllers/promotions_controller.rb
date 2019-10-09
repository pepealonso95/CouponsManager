require 'jwt'
class PromotionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:testToken]
  skip_before_action :authenticate_user!, only: [:evaluate, :testToken, :report_rest]
  before_action :is_admin? , only: [:new, :create, :destroy]

  def new
    logger.info "new promotion"
    logger.info ENV['GMAIL_USERNAME']
    @promotion = Promotion.new
  end

  def show
    logger.info "new promotion shown"
    @promotion = cached_promotion
  end

  def cached_promotion
    Rails.cache.fetch("promotion-#{promotion_id}", :expires_in => 10.minutes) do
      Promotion.find(promotion_id)
    end
  end

  def report 
     @promotion = cached_promotion
     @average = (@promotion.total_response_time / @promotion.total_requests)
     if @promotion.negative_response == 0
        @rate = (@promotion.positive_response)
     else
      @rate = "#{@promotion.positive_response}/#{@promotion.negative_response}"
     end 
  end   

  def report_rest 
    token = request.headers["token"]
    payload = JWT.decode token, nil, false
    contains  = payload[0]["promotions"].include? "#{promotion_id}"
    if contains
      @promotion = cached_promotion
      @average = (@promotion.total_response_time / @promotion.total_requests)
      if @promotion.negative_response == 0
        @rate = (@promotion.positive_response)
      else
      @rate = "#{@promotion.positive_response}/#{@promotion.negative_response}"
      end 
      render json: {name: @promotion.name, invocations: @promotion.total_requests, positive_rate: @rate, average_time: @average}, status: :ok
    else
      render json: "unauthorized", status: :unauthorized
    end
    rescue
      render json: "internal server error", status: :error
  end   

  def create
    @promotion = Promotion.new(promotion_params)

    if @promotion.save
      redirect_to promotions_path
    end
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
      Rails.cache.delete("transaction-#{transaction_id}-#{promotion_id}")
      redirect_to promotions_path
    end
  end

  def cached_transaction
    Rails.cache.fetch("transaction-#{transaction_id}-#{promotion_id}", :expires_in => 12.hours) do
      @promotion.transactions.exists?(transaction_code: transaction_id)
    end
  end


  def evaluate
    token = request.headers["token"]
    payload = JWT.decode token, nil, false
    contains  = payload[0]["promotions"].include? "#{promotion_id}"
    if contains
      start_time = Time.now
      @promotion = cached_promotion
      if @promotion.active
        valid = false
        if @promotion.promotion_type==0
          transaction = cached_transaction
          unless transaction
            valid = true
            Rails.cache.delete("transaction-#{transaction_id}-#{promotion_id}")
          end
        elsif @promotion.promotion_type==1
          if @promotion.total_requests==0 and @promotion.cupon_code==cupon_code
            valid = true
          end
        end
        if valid 
          require 'json'
          condition = JSON.parse(@promotion.condition)
          applies = Condition.getResult(condition,total,quantity_product_size)
          if applies
            if @promotion.is_percentage
              @result = total-total*(@promotion.return_value/100)
              totalSpentAdd = @result
            else
              @result = @promotion.return_value
            end
            positiveAdd = 1
            if @promotion.promotion_type==0
              @transaction = Transaction.new(transaction_code: transaction_id, promotion_id: promotion_id)
              @transaction.save
            end
          else
            negativeAdd = 1
            @result = false
          end
        else
          negativeAdd = 1
          @result = false
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
      render json: "unauthorized", status: :unauthorized
    end
    rescue
      render json: "internal server error", status: :error
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
    token = request.headers["token"]
    payload = JWT.decode token, nil, false
    contains  = payload[0]["promotions"].include? "38"
    render json: { status: contains }, status: :ok
  end

  def viewCode
    @token = params[:id]
    render :viewCode
  end


  # def testPromotion
  #   @promotion = Promotion.find(5)
  #   @result = Condition.new(@promotion.condition)
  #   @result = @condition.getResult(30,300,400)
  #   render :create
  # end

  def index
    @promotions = Promotion.where(organization_id: current_user.organization_id)
    if name && name!=""
      @promotions = @promotions.where(name: name)
    end
    if cupon_code && cupon_code!=""
      @promotions = @promotions.where(cupon_code: cupon_code)
    end
    if active && active!=""
      @promotions = @promotions.where(active: active)
    end
    if promotion_type && promotion_type!=""
      @promotions = @promotions.where(promotion_type: promotion_type)
    end
  end
  

  def promotion_params
    params.require(:promotion).permit(:name, :cupon_code, :condition, :active, :promotion_type, :return_value, :is_percentage, :organization_id)
  end

  def edit_promotion_params
    params.require(:promotion).permit(:name, :cupon_code, :condition, :active, :promotion_type, :return_value, :is_percentage, :organization_id)
  end

  def promotion_id
    params.require(:id)
  end

  def total
    params.require(:total).to_i
  end

  def quantity_product_size
    params.permit(:quantity_product_size)['quantity_product_size'].to_i
  end

  def cupon_code
    params.permit(:cupon_code)['cupon_code']
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

  def transaction_id
    params.permit(:transaction_id)['transaction_id']
  end
end
