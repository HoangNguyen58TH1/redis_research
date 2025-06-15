REDIS_URL = ENV.fetch('REDIS_URL', 'redis://localhost:6379/2')

# init connect directly to Redis
$redis = Redis.new(url: REDIS_URL)

# Config cache store use Rails.cache (> rails v5)
Rails.application.config.cache_store = :redis_cache_store, {
  url: REDIS_URL,
  namespace: 'cache',         # optional: help identify cache keys
  expires_in: 1.hour,         # TTL (time to live) default
  compress: true              # optional: compress big data
}
