require 'spec_helper'

RSpec.describe 'Gdax integration specs' do
  client = Cryptoexchange::Client.new

  it 'fetch pairs' do
    pairs = client.pairs('gdax')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'gdax'
  end

  it 'fetch ticker' do
    btc_usd_pair = Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USD', market: 'gdax')
    ticker = client.ticker(btc_usd_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'gdax'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(DateTime.strptime(ticker.timestamp.to_s, '%s').year).to eq Date.today.year
    expect(ticker.payload).to_not be nil
  end
end
