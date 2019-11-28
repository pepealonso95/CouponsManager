class ExpirationMailer < ApplicationMailer
    default from: 'arquisoftpract19@gmail.com'

    def expiration_mail(promotion,admin)
      mail(to: "#{admin.email}", subject: "Vencerá un cupon de #{promotion.name}")
    end
end
