# app/workers/hard_worker.rb
class HardWorker
  include Sidekiq::Worker

  def perform()
    p 'Hello World!'
    promotions = Promotion.all
    admins = Admin.all
    promotions.each do |promotion|
      if promotion.expiration <= DateTime.now + 1.days  && promotion.send == 1
         promotion.send = 2
         promotion.save
         admins.each do |admin| 
            ExpirationMailer.expiration_mail(promotion,admin).deliver    
         end  
      end 
      if DateTime.now >= promotion.expiration && promotion.send == 2
         promotion.send = 0
         promotion.save
         admins.each do |admin| 
           PromotionMailer.promotion_mail(promotion,admin).deliver    
         end 
      end 
    end
  end 
end
