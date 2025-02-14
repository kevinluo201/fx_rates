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
      query[:currencies] = currencies_params(params[:currencies]) if params[:currencies]

      RatesResponse.new(@requset.get('/latest', query))
    end

    def historical(**params)
      query = {}
      query[:date] = (params[:date] || Time.now.utc).strftime('%Y-%m-%d')
      query[:base] = params[:base] || 'USD'
      query[:currencies] = currencies_params(params[:currencies]) if params[:currencies]
      query[:amount] = params[:amount] || 1
      query[:places] = params[:places] if params[:places]

      RatesResponse.new(@requset.get('/historical', query))
    end

    def currencies
      @requset.get('/currencies')
    end

    private

    def currencies_params(currencies)
      currencies.is_a?(Array) ? currencies.join(',') : nil
    end
  end
end