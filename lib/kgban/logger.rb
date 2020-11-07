module Kgban
  class Logger < ::Logger
    class Formatter < ::Logger::Formatter
      def call(severity, time, progname, msg)
        "#{String === msg ? msg : msg.inspect}\n"
      end
    end

    class LogDevice < ::Logger::LogDevice
      def add_log_header(file)
        # NOTE: 標準ライブラリのLoggerが出力するヘッダを除去するためoverrideしています
      end
    end

    def initialize(logdev, shift_age = 0, shift_size = 1_048_576, formatter: Formatter.new)
      dev = LogDevice.new(logdev, shift_age: shift_age, shift_size: shift_size)
      super(dev, shift_age, shift_size, formatter: formatter)
    end
  end
end
