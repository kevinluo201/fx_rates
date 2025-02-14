module FXRates::Response
  class Rates
    attr_reader :success, :rates, :timestamp, :date, :base, :raw_response

    def initialize(response)
      @success = response["success"]
      @rates = response["rates"]
      @timestamp = response["timestamp"]
      @date = response["date"]
      @base = response["base"]
      @raw_response = response
    end
  end
end
