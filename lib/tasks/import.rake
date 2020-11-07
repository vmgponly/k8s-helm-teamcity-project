namespace :import do
  desc 'Create or update cache of device_bans'
  task device_bans: :environment do
    DeviceBan.import!
  end

  desc 'Create or update cache of device_app_bans'
  task device_app_bans: :environment do
    DeviceAppBan.import!
  end
end
