require 'httpclient'
require 'uri'
require 'openssl'
require 'json'
require 'active_support/core_ext/hash/compact'

module Coincheck
  class API

    VERSION = '0.1.0'

    def initialize(access_key='', secret_key='')
      @access_key = access_key
      @secret_key = secret_key
    end

    def ticker
      Client.new(@access_key, @secret_key, '/api/ticker').get
    end

    def trades(offset:nil)
      params = {
        offset:offset
      }.compact
      Client.new(@access_key, @secret_key, '/api/trades', params).get
    end

    def order_books
      Client.new(@access_key, @secret_key, '/api/order_books').get
    end

    def exchange_orders_rate(order_type:, pair:, amount:nil, price:nil)
      params = {
        order_type:order_type,
        pair:pair,
        amount:amount,
        price:price
      }.compact
      Client.new(@access_key, @secret_key, '/api/exchange/orders/rate', params).get
    end

    def rate(pair:)
      Client.new(@access_key, @secret_key, "/api/rate/#{pair}").get
    end

    class Client

      def initialize(access_key='', secret_key='', path='', params={})
        @access_key = access_key
        @secret_key = secret_key
        @path = path
        @params = params
      end

      def get
        http = HTTPClient.new
        response = http.get(uri, query, header.to_a)
        return JSON.parse(response.body) if response.ok?
        raise response.reason
      end

      def uri
        @uri ||= URI.parse("https://#{host}#{path}")
      end

      def host
        'coincheck.com'
      end

      def path
        @path
      end

      def query
        @params
      end

      def header
        return {} if @access_key.empty? || @secret_key.empty?
        key = @access_key
        nonce = Time.now.to_i.to_s
        message = nonce + uri.to_s + URI.encode_www_form(query)
        signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), @secret_key, message)
        {
          'ACCESS-KEY' => key,
          'ACCESS-NONCE' => nonce,
          'ACCESS-SIGNATURE' => signature
        }
      end

    end

  end
end
