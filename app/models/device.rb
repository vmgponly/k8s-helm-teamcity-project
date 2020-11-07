require 'nws/deneb'
require 'nws/altair'

class Device
  include ActiveModel::Model

  attr_accessor :serial_number

  validates :serial_number, presence: true

  def ban_status
    res = Struct.new(:serial_number, :status).new(serial_number, '.free')

    if DeviceBan.exists?(serial_number: serial_number)
      res.status = '.device_ban.banned'
      return res
    end

    if DeviceAppBan.exists?(serial_number: serial_number)
      res.status = '.device_app_ban.banned'
    end

    res
  end
end
