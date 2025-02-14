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

      Response::Rates.new(@requset.get('/latest', query))
    end

    def historical(**params)
      query = {}
      query[:date] = (params[:date] || Time.now.utc).strftime('%Y-%m-%d')
      query[:base] = params[:base] || 'USD'
      query[:currencies] = currencies_params(params[:currencies]) if params[:currencies]
      query[:amount] = params[:amount] || 1
      query[:places] = params[:places] if params[:places]

      Response::Rates.new(@requset.get('/historical', query))
    end

    def timeseries(start_date:, end_date:, accuracy: 'day', **params)
      if !start_date.match?(/\d{4}-\d{2}-\d{2}/) && !start_date.match?(/\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}/)
        raise ArgumentError, "Invalid start_date format. Must be in the YYYY-MM-DD or YYYY-MM-DDTHH:mm:ss format"
      end
      if !end_date.match?(/\d{4}-\d{2}-\d{2}/) && !end_date.match?(/\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}/)
        raise ArgumentError, "Invalid end_date format. Must be in the YYYY-MM-DD or YYYY-MM-DDTHH:mm:ss format"
      end

      query = {
        start_date: start_date,
        end_date: end_date,
        accuracy: accuracy
      }
      query[:currencies] = currencies_params(params[:currencies]) if params[:currencies]
      query[:base] = params[:base] || 'USD'
      query[:amount] = params[:amount] || 1
      query[:places] = params[:places] if params[:places]

      Response::Timeseries.new(@requset.get('/timeseries', query))
    end

    def convert(from:, to:, **params)
      query = {
        from: from,
        to: to
      }
      query[:date] = (params[:date] || Time.now.utc).strftime('%Y-%m-%d')
      query[:amount] = params[:amount] || 1
      query[:places] = params[:places] if params[:places]

      Response::Convert.new(@requset.get('/convert', query))
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