require 'kgban/logger'

Rails.application.configure do
  config.access_logger = Kgban::Logger.new(
    Rails.root.join('log', 'access.log'),
    Settings.logger.access.shift_age,
    Settings.logger.access.shift_size
  )
end
