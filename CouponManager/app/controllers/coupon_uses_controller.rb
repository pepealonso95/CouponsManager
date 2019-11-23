class CouponUsesController < ApplicationController

  def new
    @coupon_use = CouponUse.new
  end

  
  def create
    @coupon_use = CouponUse.new(coupon_params)
    redirect_to coupon_uses_path if @coupon_use.save
  end

  def index
    @coupon_uses = CouponUse.joins(:promotion).where(promotions: { organization_id: current_user.organization_id })
  end

  def coupon_params
    params.require(:coupon_use).permit(:coupon_code, :remaining_uses, :valid_limit, :promotion_id)
  end
end
