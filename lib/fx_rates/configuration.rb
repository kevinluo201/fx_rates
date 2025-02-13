module FXRates
  class Configuration
    attr_accessor :api_key, :api_base_url

    def initialize
      @api_key = nil
      @api_base_url = "https://api.fxratesapi.com"
    end
  end
end