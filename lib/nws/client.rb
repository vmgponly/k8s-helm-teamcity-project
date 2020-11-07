require 'nws/mash'

module Nws
  class Client
    attr_reader :environment

    def initialize(environment:)
      @environment = environment
    end

    %w[get head delete post put patch].each do |method|
      class_eval <<-RUBY, __FILE__, __LINE__ + 1
        def #{method}(url = nil, params = nil, headers = nil, &block)
          http_client.#{method}(url, params, headers, &block)
        end
      RUBY
    end

    def client_options
      {}
    end

    def configure_middlewares(conn)
      conn.request  :url_encoded
      conn.request  :json
      conn.response :raise_error
      conn.response :mashify, mash_class: Nws::Mash # NOTE: This line must be placed before JSON middleware
      conn.response :json, content_type: /\bjson$/ # \b : word boundaries
      conn.adapter  Faraday.default_adapter
    end

    private

      def http_client
        @http_client ||= Faraday.new(client_options, &method(:configure_middlewares))
      end

      def basic_auth_token(username, password)
        Base64.strict_encode64("#{username}:#{password}")
      end

      def query_from_hash(hash)
        hash.map { |k, v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}" } * '&'
      end
  end
end
