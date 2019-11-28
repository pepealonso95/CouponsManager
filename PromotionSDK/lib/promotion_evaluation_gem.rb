require 'rest-client'
require 'json'

# https://guides.rubygems.org/make-your-own-gem/
# gem build country_time_service.gemspec

class PromotionEvaluation

    def evaluatePromotion(id, conditions, token)
        time = Time.now.getutc
        response = RestClient.post "#{url}?id=#{id}", conditions.to_json, {content_type: :json, accept: :json, token: token}
        time = Time.now.getutc - time
        if (response.code == 200 && time < 1000) 
            response.body
        else
            raise "No aplica"
        end
    end
    
    
    def url
        'https://coupon-manager-arquitectura.herokuapp.com/promotions/evaluate'
    end

end