class PromotionMailer < ApplicationMailer
    default from: 'arquisoftpract19@gmail.com'

    def promotion_mail(promotion,admin)
      mail(to: "#{admin.email}", subject: "Se venció #{promotion.name}")
    end
end