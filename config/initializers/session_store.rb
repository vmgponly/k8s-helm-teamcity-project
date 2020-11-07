Rails.application.config.session_store(
  :redis_store,
  servers: [
    {
      host: Settings.redis.host,
      port: Settings.redis.port,
      db:   Settings.redis.db
    }
  ],
  # システム名は使わないほうが良いので、SecureRandom.hexな値を使う
  key: '99762d47f0fe3e02'
)
