module FXRates::Response
  class Timeseries
    attr_reader :success, :rates, :start_date, :end_date, :base, :raw_response

    def initialize(response)
      @success = response["success"]
      @rates = response["rates"]
      @start_date = response["start_date"]
      @end_date = response["end_date"]
      @base = response["base"]
      @raw_response = response
    end
  end
end
