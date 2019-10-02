class PromotionsController < ApplicationController
  def new
    @promotion = Promotion.new
  end

  def show
    @promotion = Promotion.find(promotion_id)
  end

  def create

  end

  def create
    @organization = Organization.find(1);
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
  end


  def evaluate
    @promotion = Promotion.find(promotion_id)
    require 'json'
    condition = JSON.parse(@promotion.condition)
    @result = Condition.getResult(condition,total,quantity,product_size)
    render :create
  end


  # def testPromotion
  #   @promotion = Promotion.find(5)
  #   @result = Condition.new(@promotion.condition)
  #   @result = @condition.getResult(30,300,400)
  #   render :create
  # end

  def newCondition
    
  end

  def index
    @promotions = Promotion.all
  end

  def promotion_params
    params.require(:promotion).permit(:name, :cupon_code, :condition)
  end

  def edit_promotion_params
    params.require(:promotion).permit(:name, :cupon_code, :condition)
  end

  def promotion_id
    params.require(:id)
  end

  def total
    params.require(:total).to_i
  end

  def quantity
    params.permit(:quantity)['quantity'].to_i
  end

  def product_size
    params.permit(:product_size)['product_size'].to_i
  end

  def cupon_code
    params.permit(:cupon_code)
  end

  def transaction_id
    params.permit(:transaction_id)
  end
end
