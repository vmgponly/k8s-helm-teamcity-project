# frozen_string_literal: true

require 'nws/deneb/client'

module Nws
  module Deneb
    class BanClient < Nws::Deneb::Client
      def initialize(environment:)
        super(environment: environment)
      end

      def version
        'v1'
      end

      def get_device_bans
        device_bans = []
        offset = 0
        length = 0
        total = nil
        while total.nil? || offset < total
          res = get "#{version}/device_bans" do |req|
            req.headers['Authorization'] = "Bearer #{Rails.application.credentials[@environment.to_sym][:access_token][:deneb]}"
            #req.headers['Authorization'] = "Bearer #{Rails.application.credentials.dig(Rails.env.to_sym, :access_token, :deneb)}"
            req.params = {
              offset: offset
            }
          end
          attributes = res.body['_attributes']
          total = attributes['total']
          length = attributes['length']
          offset += length

          device_bans += res.body['device_bans']
        end
        device_bans
      end
    end
  end
end
