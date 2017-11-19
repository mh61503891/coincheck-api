RSpec.describe Coincheck::API do

  it '#version' do
    expect(Coincheck::API::VERSION).not_to be nil
  end

  let(:api) { Coincheck::API.new }

  it '#ticker' do
    api.ticker
  end

  it '#trades' do
    api.trades(offset:50)
  end

  it '#order_books' do
    api.order_books
  end

  it '#exchange_orders_rate' do
    api.exchange_orders_rate(order_type:'sell', pair:'btc_jpy', amount:0.1)
    api.exchange_orders_rate(order_type:'sell', pair:'btc_jpy', price:28000)
    expect {
      api.exchange_orders_rate(order_type:'sell', pair:'btc_jpy')
    }.to raise_error(RuntimeError, 'Bad Request')
    expect {
      api.exchange_orders_rate(order_type:'sell', pair:'btc_jpy', amount:0.1, price:28000)
    }.to raise_error(RuntimeError, 'Bad Request')
  end

  it '#rate' do
    api.rate(pair:'btc_jpy')
  end

end
