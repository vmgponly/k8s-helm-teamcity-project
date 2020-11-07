require 'nws/client'

module Nws
  module Deneb
    class Client < Nws::Client
      FQDN = {
        sandbox: 'dapi-sandbox.ndas.srv.nintendo.net',
        td1:     'dapi-td1.ndas.srv.nintendo.net',
        jd1:     'dapi-jd1.ndas.srv.nintendo.net',
        dd1:     'dapi-dd1.ndas.srv.nintendo.net',
        dp1:     'dapi-dp1.ndas.srv.nintendo.net',
        sd1:     'dapi-sd1.ndas.srv.nintendo.net',
        sp1:     'dapi-sp1.ndas.srv.nintendo.net',
        lp1:     'dapi-lp1.ndas.srv.nintendo.net'
      }.freeze

      def client_options
        {
          url: "https://#{FQDN[environment]}"
        }
      end

      def version
        raise NotImplementedError
      end
    end
  end
end
