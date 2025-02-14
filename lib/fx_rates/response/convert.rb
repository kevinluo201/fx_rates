module FXRates::Response
  class Convert
    attr_reader :success, :from, :to, :amount, :rate, :date, :timestamp, :result, :raw_response

    def initialize(response)
      @success = response["success"]
      @from = response["query"]["from"]
      @to = response["query"]["to"]
      @amount = response["query"]["amount"]
      @rate = response["info"]["rate"]
      @date = response["date"]
      @timestamp = response["timestamp"]
      @result = response["result"]
      @raw_response = response
    end
  end
end
