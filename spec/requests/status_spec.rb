# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/status' do
  describe 'GET /' do
    subject { response }

    before { get root_path }

    it { should have_http_status(:ok) }
  end

  describe 'POST /status' do
    let(:serial_number) { 'XAW0123456789' }

    subject { response }

    before do
      post status_path, params: { serial_number: serial_number }
    end

    it { should redirect_to(status_link_url(serial_number)) }
  end

  describe 'GET /status/${SERIAL_NUMBER}' do
    let(:serial_number) { 'XAW0123456789' }

    subject { response }

    before do
      get status_link_path(serial_number)
    end

    it { should redirect_to(root_url(serial_number: serial_number)) }
  end

  describe 'GET /?serial_number=${SERIAL_NUMBER}' do
    let(:serial_number) { 'XAW0123456789' }

    subject { response.body }

    before do
      get root_path(serial_number: serial_number)
    end

    it { should include('Nintendo Switch Network Restriction Checker') }
    it { should include(serial_number) }
    it { should include('https://www.nintendo.com/privacy-policy') }
  end
end
