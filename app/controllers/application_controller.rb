class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  before_action :delete_forwarded_host
  after_action  :write_access_log

  private

    def delete_forwarded_host
      # X-Forwarded-Hostヘッダは無視する
      # セキュリティ診断での指摘事項への対応
      request.headers['HTTP_X_FORWARDED_HOST'] = nil if request.headers['HTTP_X_FORWARDED_HOST']
    end

    def write_access_log
      Rails.application.config.access_logger.info(
        LTSV.dump(
          {
            timestamp:     Time.zone.now.iso8601,
            method:        request.method,
            path:          request.original_fullpath,
            remote_ip:     masked_ip,
            user_agent:    request.user_agent,
            status:        response.status,
            serial_number: @serial_number
          }
        )
      )
    end

    def masked_ip
      request.remote_ip&.gsub(/\.[0-9]+\z/, '.XXX')
    end
end
