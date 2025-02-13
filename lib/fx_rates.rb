require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect(
  "fx_rates" => "FXRates",
)
loader.setup

module FXRates
  # Your code goes here...
end
