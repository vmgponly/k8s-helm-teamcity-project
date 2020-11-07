# frozen_string_literal: true

require 'nws/altair'

class DeviceAppBan
  include ActiveModel::Model
  include ActiveModel::Attributes
  include BanCache

  # refs: https://spdlybra.nintendo.co.jp/confluence/pages/viewpage.action?pageId=110929800
  attribute :id,                  :integer
  attribute :device_id,           :string
  attribute :serial_number,       :string
  attribute :comment,             :string
  attribute :expires_at,          :datetime
  attribute :updated_by,          :string
  attribute :created_by,          :string
  attribute :created_at,          :datetime
  attribute :updated_at,          :datetime
  attribute :omas_application_id, :string
  attribute :via,                 :string

  class << self
    private

    def original_data
      Nws::Altair::BanClient.new(environment: ENV.fetch('ENVIRONMENT', 'sandbox').to_sym).get_device_app_bans
    end
  end
end
