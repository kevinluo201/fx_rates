# FXRates

`fx_rates` is an API wrapper for https://fxratesapi.com/. I don't work for them. I just like their service very much, so I made this gem to let rubists access their service easier.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fx_rates'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fx_rates

## Usage

### Initialize

You can initialize `FXRates::Client` with an API key you get on https://fxratesapi.com/.

```ruby
client = FXRates::Client.new(api_key: 'fxr_live_xxxxxxxxxxxxxxxxxxxxxxxxxx') # api key is required!

# Or you can configure
FXRates.configure do |config|
  config.api_key = 'fxr_live_xxxxxxxxxxxxxxxxxxxxxxxxxx'
end
client = FXRates::Client.new
```

Then you can call FXRates API endpoints with the this `client`

### latest

`#latest` returns the latest rates based on the base currency.

```ruby
response = client.latest
response.base
# "USD"
response.rates
# All available currencies and their exchange rates
# {"ADA"=>1.2661080459, "AED"=>3.6726003855, ... }
response.date
# "2025-02-15T19:14:00.000Z"
response.timestamp
# 1739646840

# you can specify the parameters
response = client.latest(base: 'CAD', currencies: ['USD', 'JPY', 'TWD'])
```
#### Available parameters

| Parameter      | Description                                                                                                                                                                                                                              | Default                                    |
| -------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------ |
| **resolution** | Specifies the update interval of the exchange rates. Available options:<br> - `1d` - daily<br> - `1h` - hourly<br> - `10m` - every 10 minutes<br> - `1m` - every 60 seconds<br> Most current available rates for your subscription plan. | Most current available rates for your plan |
| **currencies** | Specifies the currencies you want exchange rates for. Multiple currencies can be separated with a comma.                                                                                                                                 | All available currencies                   |
| **base**       | Sets the currency in which exchange rates are quoted. All exchange rates are relative to this base currency.                                                                                                                             | `USD`                                      |
| **amount**     | The amount of the base currency to convert.                                                                                                                                                                                              | `1`                                        |
| **places**     | Specifies the number of decimal places in the response. By default, the most available decimal places for the currency are returned.                                                                                                     | Most available decimal places              |

### historical

`#historical` returns the exchange rates on a specific date. If the date is not given, it will use the current date.

```ruby
response = client.historical(date: '2025-01-31')
response.base
# "USD"
response.rates
# All available currencies and their exchange rates
# {"ADA"=>1.2661080459, "AED"=>3.6726003855, ... }
response.date
# "2025-02-15T19:14:00.000Z"
response.timestamp
# 1739646840

# you can specify the parameters
response = client.latest(base: 'CAD', currencies: ['USD', 'JPY', 'TWD'])
```

#### Available parameters
| Parameter      | Description                                                                                                                          | Default                      |
|:-------------- | ------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------- |
| **date**       | The date for which you want to get the exchange rates. The date must be specified in the `YYYY-MM-DD` format.                        | Current date                 |
| **base**       | Sets the currency in which exchange rates are quoted. All exchange rates are relative to this base currency.                         | `USD`                        |
| **currencies** | Specifies the currencies you want exchange rates for. Multiple currencies can be separated with a comma.                             | All available currencies     |
| **amount**     | The amount of the base currency to convert.                                                                                          | `1`                          |
| **places**     | Specifies the number of decimal places in the response. By default, the most available decimal places for the currency are returned. | All available decimal places |

### timeseries

`#timeseries` returns the rates during the specified period. `start_date` and `end_date` are required

```ruby
response = client.timeseries start_date: '2025-02-01', end_date: '2025-02-05', currencies: ['CAD', 'JPY']

response.base
# "USD"
response.start_date
# "2025-02-01T00:00:00.000Z"
response.end_date
# "2025-02-05T00:00:00.000Z"
response.rates
# {
#   "2025-02-04T23:59:00.000Z"=>{"CAD"=>1.4327402762, "JPY"=>154.1029666308},
#   "2025-02-03T23:59:00.000Z"=>{"CAD"=>1.4415901702, "JPY"=>155.2101489283},
#   "2025-02-02T23:59:00.000Z"=>{"CAD"=>1.4713002625, "JPY"=>155.3692612221},
#   "2025-02-01T23:59:00.000Z"=>{"CAD"=>1.451700235, "JPY"=>155.1286365022}
# }
```

#### Availalbe parameters

| Parameter                   | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                            | Default                  |
| --------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------ |
| **start_date** *(required)* | The start date for which you want to get the exchange rates. The date must be specified in the `YYYY-MM-DD` format or `YYYY-MM-DDTHH:mm:ss` format.                                                                                                                                                                                                                                                                                                                    | -                        |
| **end_date** *(required)*   | The end date for which you want to get the exchange rates. The date must be specified in the `YYYY-MM-DD` format or `YYYY-MM-DDTHH:mm:ss` format.                                                                                                                                                                                                                                                                                                                      | -                        |
| **accuracy**                | Specifies the interval length of the requested time series:<br> - `day` - daily (Rates available for the last 365 days)<br> - `hours` - hourly (Rates available for the last 90 days)<br> - `15m` - every 15 minutes (Rates available for the last 7 days)<br> - `10m` - every 10 minutes (Rates available for the last 7 days)<br> - `5m` - every 5 minutes (Rates available for the last 7 days)<br> - `1m` - every 60 seconds (Rates available for the last 7 days) | `day`                    |
| **currencies**              | Specifies the currencies you want exchange rates for. Multiple currencies can be separated with a comma.                                                                                                                                                                                                                                                                                                                                                               | All available currencies |
| **base**                    | Sets the currency in which exchange rates are quoted. All exchange rates are relative to this base currency.                                                                                                                                                                                                                                                                                                                                                           | `USD`                    |
| **amount**                  | The amount of the base currency to convert.                                                                                                                                                                                                                                                                                                                                                                                                                            | `1`                      |
| **places**                  | Specifies the number of decimal places in the response. By default, the most available decimal places for the currency are returned.                                                                                                                                                                                                                                                                                                                                   | All available decimals   |

### convert

`convert` calculates the conversion of 2 currencies.

```ruby
response = client.convert(from: 'USD', to: 'CAD', amount: 1000)
response.from
# "USD"
response.to
# "CAD"
response.amount
# 1000
response.result
# 1418.3401925
response.rate
# 1.4183401925
response.date
# "2025-02-15T00:07:00.000Z"
response.timestamp
# 1739578020
```

#### Available parameters
| Parameter             | Description                                                                                                   | Default      |
| --------------------- |:------------------------------------------------------------------------------------------------------------- | ------------ |
| **date**              | The date for which you want to get the exchange rates. The date must be specified in the `YYYY-MM-DD` format. | Current date |
| **from** *(required)* | The currency of the amount you are converting from.                                                           | -            |
| **to** *(required)*   | The currency you want to have the amount converted to.                                                        | -            |
| **amount**            | The amount of base currency you want to convert.                                                              | `1`          |
| **places**            | The number of decimal places in the response.                                                                 | -            |


### currencies

`currencies` returns the information of all available currencies from FXRatesAPI

```ruby
client.currencies
```

### Raw response

For all above methods, you can call `#raw_response` to access te original JSON response

```ruby
response = client.latest
response.raw_response
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kevinluo201/fx_rates.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
