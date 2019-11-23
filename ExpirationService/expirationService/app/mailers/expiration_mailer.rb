class ExpirationMailer < ApplicationMailer
    default from: 'arquisoftpract19@gmail.com'

    def expiration_mail(promotion,admin)
      mail(to: "#{admin.email}", subject: "Se vencio un cupon de #{promotion.name}")
    end
end
