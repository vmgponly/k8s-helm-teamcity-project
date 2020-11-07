class BansController < ApplicationController
  before_action :set_serial_number, only: :show
  before_action :ip_base_restriction!, only: :show, if: -> { request.get? }

  def index
    @device = Device.new(serial_number: params[:serial_number])
  end

  def show
    if request.post?
      session[:post_show_bans_called] = true
      redirect_to status_link_url(serial_number: @serial_number)
    else
      # 直前にPOST bans#showが呼ばれていない場合、直リンクと判断してroot_urlへリダイレクトさせる
      redirect_to root_url(serial_number: @serial_number) unless session.delete(:post_show_bans_called)
      @status = Device.new(serial_number: @serial_number).ban_status
    end
  end

  private

  def set_serial_number
    @serial_number = params.require(:serial_number).to_s.gsub(/[^\w]/, '')
  rescue
    redirect_to root_url
  end

  # NOTE: 同一IPアドレスからのアクセスは `duration` 以内に `max_count` 未満のアクセスしか受け付けない。
  #       アクセス上限を超過したアクセスがあった場合は `duration` 時間経過しないと再アクセス可能にならない。
  def ip_base_restriction!
    ip_address = request.remote_ip
    count = Rails.cache.redis.keys("#{ip_address}#*").count
    if count >= Settings.ip_restriction.max_count
      redirect_to root_url, alert: I18n.t('errors.ip_restriction')
      return
    end
    Rails.cache.write("#{ip_address}##{Time.zone.now.to_f}", count, expires_in: Settings.ip_restriction.duration)
  end
end
