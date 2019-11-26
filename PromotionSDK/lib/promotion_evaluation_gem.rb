require 'rest-client'
require 'json'

# https://guides.rubygems.org/make-your-own-gem/
# gem build country_time_service.gemspec

class CountryTimeService

    def evaluatePromotion(promotion)
        response = RestClient.get url, { params: { promotion: promotion } }
        if response.code == 200
            JSON.parse(response.body)
        else
            raise "An error has occured. Response was #{response.code}"
        end
    end

    private

    def url
        'http://localhost.com'
    end

end