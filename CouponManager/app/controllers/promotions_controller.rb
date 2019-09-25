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
    @promotion = Promotion.new(promotion_params)
    @promotion.date = DateTime.current

    if @promotion.save
      redirect_to promotions_path
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def index
    @promotions = Promotion.all
  end
end
