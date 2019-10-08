require 'jwt'
class PromotionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:evaluate]
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
    @promotion = Promotion.find(promotion_id)
    require 'json'
    condition = JSON.parse(@promotion.condition)
    @result = Condition.getResult(condition,total,quantity_product_size)
    render :create
  end


  def authorizationCodes
    @promotions = Promotion.all
  
    render :authorizationCodes
  end

  def getCode
    promotionIds = params[:promotionIds]
    payload = { promotionIds: promotionIds }
    # IMPORTANT: set nil as password parameter
    token = JWT.encode payload, nil, 'none'
    redirect_to controller: 'promotions', id: token, action: 'viewCode'


    # render json: { status: token}, status: :ok
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
    params.permit(:transaction_id)
  end
end
