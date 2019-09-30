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


  def testPromotion
    @condition3 = Condition.new()
    @condition3.generatePrimitiveCondition("EQUALS", "TOTAL", 2)
    @condition2 = Condition.new()
    @condition2.generatePrimitiveCondition("EQUALS", "TOTAL", 3)
    
    @condition = Condition.new()
    @condition.generateNestedCondition("AND", @condition3, @condition2)
    @result = @condition.getResult(2,3,4)
    render :create
  end

  def newCondition
    
  end

  def index
    @promotions = Promotion.all
  end

  def promotion_params
    params.require(:promotion).permit(:name, :cupon_code)
  end

  def edit_promotion_params
    params.require(:promotion).permit(:name, :cupon_code)
  end

  def promotion_id
    params.require(:id)
  end
end
