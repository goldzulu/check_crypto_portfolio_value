# Check Your Crypto Portfolio value

This is a quick little script I wrote to give me the total value of my crypto portfolio, as I got tired of doing it manually.

This uses the (https://coinmarketcap.com/api/)[coinmarketcap] API to get the current pricing information.

## Installing

This uses the `rest-client` gem, so you need to install it. I have a `Gemfile`, so you can either install manually or with bundler:

> gem install rest-client

or

> bundle install

## Running

The coinmarketcap api key is set using an environment variable, `COINMARKETCAP_API_KEY`, and the coins to check are passed as an argument: `SYMBOL1:AMOUNT1;SYMBOL2:AMOUNT2`.

Example
```
COINMARKETCAP_API_KEY="b54bcf4d-1bca-4e8e-9a24-22ff2c3d462c" ruby checkcrypto.rb "BTC:1;ETH:1"
```

and you get an output

```
BTC count: 1 quote: $39,322.42 value: $39,322.42
ETH count: 1 quote: $1,684.36 value: $1,684.36
Portfolio Value: $41,006.78
```
