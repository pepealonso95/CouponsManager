require 'jwt'
class PromotionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:testToken]
  skip_before_action :authenticate_user!, only: [:evaluate, :testToken]
  before_action :is_admin? , only: [:new, :create, :destroy, :index, :show]

  def new
    logger.info "new promotion"
    logger.info ENV['GMAIL_USERNAME']
    @promotion = Promotion.new
  end

  def show
    logger.info "new promotion shown"
    @promotion = Promotion.find(promotion_id)
  end



  def report 
     @promotion = Promotion.find(promotion_id)
     railsReturn = Rails.cache.fetch('#{promotion_id}');
     hash = JSON.parse(railsReturn)
     positiveResponse = hash["positive_response"]
     negativeResponse = hash["negative_response"]
     totalResponseTime = hash["total_response_time"]
     totalRequests = hash["total_requests"]
     @average = (totalResponseTime.to_i / totalRequests.to_i)
     if negativeResponse.to_i == 0
        @rate = (positiveResponse.to_i)
     else
      @rate = (positiveResponse.to_i / negativeResponse.to_i)
     end 

  end   


  def create
    @promotion = Promotion.new(promotion_params)

    if @promotion.save
      redirect_to promotions_path
    end
  end

  def update
    @promotion = Promotion.find(promotion_id)
    if @promotion.update(edit_promotion_params)
      redirect_to promotions_path
    else
      render :edit
    end
  end

  def edit
    @promotion = Promotion.find(promotion_id)
  end

  def destroy
    @promotion = Promotion.find(promotion_id)
    if @promotion.update(active: false)
      redirect_to promotions_path
    end
  end


  def evaluate
    start_time = Time.now
    @promotion = Promotion.find(promotion_id)
    valid = false
    if @promotion.promotion_type==0
      transaction = Transaction.where(transaction: transaction_id, promotion_id: promotion_id).exists?(conditions = :none)
      unless transaction
        valid = true
      end
    elsif @promotion.promotion_type==1
      if @promotion.total_requests==0
        valid = true
      end
    end
    if valid
      require 'json'
      condition = JSON.parse(@promotion.condition)
      applies = Condition.getResult(condition,total,quantity_product_size)
      if applies
        if @promotion.is_percentage
          @result = total*(@promotion.return_value/100)
        else
          @result = @promotion.return_value
        end
      else
        @result = false
      end
    else
      @result = false
    end
    total_time = Time.now - start_time
    @promotion.update_attributes(:total_response_time => @promotion.total_response_time + (total_time * 1000))
    @promotion.update_attributes(:total_requests => @promotion.total_requests + 1)
    if @result!=false
      @promotion.update_attributes(:positive_response => @promotion.positive_response + 1)
    else
      @promotion.update_attributes(:negative_response => @promotion.negative_response + 1)
    end
    Rails.cache.write('#{promotion_id}', @promotion.to_json) 
    render :create
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
    render json: { status: payload }, status: :ok
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
    @promotions = Promotion.all
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
    params.permit(:cupon_code)
  end

  def transaction_id
    params.permit(:transaction_id)['transaction_id']
  end
end
