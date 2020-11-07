require 'nws/client'

module Nws
  module Altair
    class Client < Nws::Client
      FQDN = {
        sandbox: 'aapi-sandbox.ndas.srv.nintendo.net',
        td1:     'aapi-td1.ndas.srv.nintendo.net',
        jd1:     'aapi-jd1.ndas.srv.nintendo.net',
        dd1:     'aapi-dd1.ndas.srv.nintendo.net',
        dp1:     'aapi-dp1.ndas.srv.nintendo.net',
        sd1:     'aapi-sd1.ndas.srv.nintendo.net',
        sp1:     'aapi-sp1.ndas.srv.nintendo.net',
        lp1:     'aapi-lp1.ndas.srv.nintendo.net'
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
