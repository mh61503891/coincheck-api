require 'httpclient'
require 'uri'
require 'openssl'
require 'json'

module Coincheck
  class API

    VERSION = '0.1.0'

    def initialize(access_key, secret_key)
      @access_key = access_key
      @secret_key = secret_key
    end

    def ticker
      client = Client.new(@access_key, @secret_key, '/api/ticker')
      client.get('/api/ticker')
    end

    class Client

      def initialize(access_key, secret_key, path='', params={})
        @access_key = access_key
        @secret_key = secret_key
        @path = path
        @params = params
      end

      def get
        http = HTTPClient.new
        response = http.get(uri, query, header.to_a)
        JSON.parse(response.body)
      end

      def uri
        @uri ||= URI.parse("https://#{host}#{@path}")
      end

      def host
        'coincheck.com'
      end

    end

  end
end
