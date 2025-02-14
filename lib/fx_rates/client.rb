module FXRates
  class Client
    def initialize(api_key: nil)
      @api_key = api_key || FXRates.config&.api_key
      @requset = FXRates::Request.new(@api_key)
    end

    def latest(**params)
      query = {}
      query[:base] = params[:base] || 'USD'
      query[:amount] = params[:amount] || 1
      query[:places] = params[:places] if params[:places]
      query[:resolution] = params[:resolution] if params[:resolution]
      if params[:currencies] && params[:currencies].is_a?(Array)
        query[:currencies] = params[:currencies].join(',')
      end

      RatesResponse.new(@requset.get('/latest', query))
    end

    def currencies
      @requset.get('/currencies')
    end
  end
end