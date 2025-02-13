require "faraday"
require "json"

module FXRates
  class Request
    BASE_URL = "https://api.fxratesapi.com"

    def initialize(api_key)
      raise FXRates::AuthenticationError, "API key is required" if api_key.nil?

      @api_key = api_key
    end

    def get(path, params = {})
      response = connection.get(path, params)
      handle_response(response)
    end

    private

    def connection
      Faraday.new(
        url: BASE_URL,
        headers: {
          "Authorization" => "Bearer #{@api_key}",
          "Content-Type" => "application/json"
        }
      )
    end

    def handle_response(response)
      case response.status
      when 200..299
        JSON.parse(response.body)
      when 401
        raise FXRates::AuthenticationError, "Invalid API key"
      else
        raise FXRates::Error, "Unexpected error: #{response.reason_phrase}. Error message: #{response.body}"
      end
    end
  end
end
