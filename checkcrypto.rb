# Pass currencies to check as argument as "BTC:1;ETH:1" etc
# Set your coinmarket cap api key as environment variable COINMARKETCAP_API_KEY
# e.g.
# COINMARKETCAP_API_KEY="key-here" ruby checkcrypto.rb "BTC:1;ETH:2"

# sandbox values for testing
#url = "https://sandbox-api.coinmarketcap.com"
#key = "b54bcf4d-1bca-4e8e-9a24-22ff2c3d462c"

# production
url = "pro-api.coinmarketcap.com"
key = ENV["COINMARKETCAP_API_KEY"]

endpoint = "#{url}/v1/cryptocurrency/quotes/latest"

require "rest-client"
require 'json'
def format_currency(value)
  if value >= 1000
    "$" + value.round(2).to_s.insert(-7, ",")
  else
    "$" + value.round(2).to_s
  end
end

currencies = ARGV[0].split(";").map{|currency| currency.split(":") }.to_h.transform_values(&:to_i)

response = RestClient.get endpoint,
  "X-CMC_PRO_API_KEY" => key,
  params: {"symbol" => currencies.keys.join(",")}
data = JSON.parse(response.body)["data"]

total_value = currencies.map {|currency, amount|
  price = data.dig(currency, "quote", "USD", "price")
  [currency, amount, price]
}.inject(0) {|value, data|
  val = data[1] * data[2]
  puts "#{data[0]} count: #{data[1]} quote: #{format_currency(data[2])} value: #{format_currency(val)}"
  value += val
}

puts "Portfolio Value: #{format_currency(total_value)}"
