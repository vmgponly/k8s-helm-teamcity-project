# frozen_string_literal: true

module BanCache
  extend ActiveSupport::Concern

  class_methods do
    def import!
      remove_keys = Rails.cache.redis.keys(cache_key('*'))

      Rails.cache.redis.multi do
        original_data.each do |data|
          key = cache_key(data['serial_number'])
          Rails.cache.write(key, data.symbolize_keys)
          remove_keys.delete(key)
        end

        # BAN情報が無くなったものはキャッシュから削除
        remove_keys.each do |key|
          Rails.cache.delete(key)
        end
      end
    end

    def find_by(serial_number:)
      data = Rails.cache.read(cache_key(serial_number))

      return nil unless data

      new(data.to_h)
    end

    def exists?(serial_number:)
      !find_by(serial_number: serial_number).nil?
    end

    private

      def cache_key(serial_number)
        format('%s:%s', cache_key_prefix, serial_number)
      end

      def cache_key_prefix
        @cache_key_prefix ||= name.underscore.pluralize
      end

      def original_data
        raise NotImplementedError
      end
  end
end
