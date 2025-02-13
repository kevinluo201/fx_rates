require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect(
  "fx_rates" => "FXRates",
)
loader.setup

module FXRates
  class Error < StandardError; end
  class AuthenticationError < Error; end

  class << self
    attr_accessor :config

    def configure
      self.config ||= FXRates::Configuration.new
      yield(config) if block_given?
    end
  end
end
