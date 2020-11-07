# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeviceBan do
  describe '.exists?' do
    subject { DeviceBan.exists?(serial_number: serial_number) }

    let(:serial_number) { 'XAJ00000000000' }

    context 'Banned' do
      before { Rails.cache.write("device_bans:#{serial_number}", device_id: '0') }
      it { should be true }
    end

    context 'Not banned' do
      it { should be false }
    end
  end
end
