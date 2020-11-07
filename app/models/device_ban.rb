# frozen_string_literal: true

require 'nws/deneb'

class DeviceBan
  include ActiveModel::Model
  include ActiveModel::Attributes
  include BanCache

  # refs: https://spdlybra.nintendo.co.jp/confluence/pages/viewpage.action?pageId=110929280
  attribute :id,            :integer
  attribute :device_id,     :string
  attribute :serial_number, :string
  attribute :platform_id,   :integer
  attribute :comment,       :string
  attribute :expires_at,    :datetime
  attribute :updated_by,    :string
  attribute :created_by,    :string
  attribute :created_at,    :datetime
  attribute :updated_at,    :datetime
  attribute :ban_reason,    :string
  attribute :via,           :string

  class << self
    private

    def original_data
      Nws::Deneb::BanClient.new(environment: ENV.fetch('ENVIRONMENT', 'sandbox').to_sym).get_device_bans
    end
  end
end
