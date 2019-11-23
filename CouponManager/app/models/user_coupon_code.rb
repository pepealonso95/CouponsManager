class UserCouponCode < ApplicationRecord
    belongs_to :coupon_use
    belongs_to :user
end
