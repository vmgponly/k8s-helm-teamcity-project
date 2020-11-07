# frozen_string_literal: true

require 'nws/altair/client'

module Nws
  module Altair
    class BanClient < Nws::Altair::Client
      def initialize(environment:)
        super(environment: environment)
      end

      def version
        'v1'
      end

      def get_device_app_bans
        device_app_bans = []
        offset = 0
        length = 0
        total = nil
        while total.nil? || offset < total
          res = get "#{version}/device_app_bans" do |req|
            req.headers['Authorization'] = "Bearer #{Rails.application.credentials[@environment.to_sym][:access_token][:altair]}"
            #req.headers['Authorization'] = "Bearer #{Rails.application.credentials.dig(Rails.env.to_sym, :access_token, :altair)}"
            req.params = {
              offset: offset
            }
          end
          attributes = res.body['_attributes']
          total = attributes['total']
          length = attributes['length']
          offset += length

          device_app_bans += res.body['device_app_bans']
        end
        device_app_bans
      end
    end
  end
end
