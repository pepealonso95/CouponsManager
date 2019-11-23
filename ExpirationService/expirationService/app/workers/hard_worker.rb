# app/workers/hard_worker.rb
class HardWorker
  include Sidekiq::Worker

  def perform()
    p 'Hello World!'
    promotions = Promotion.all
    admins = Admin.all
    promotions.each do |promotion|
      if promotion.expiration < DateTime.now
         admins.each do |admin| 
            ExpirationMailer.expiration_mail(promotion,admin).deliver
         end  
      end  
    end
  end 
end
