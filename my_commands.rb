# 1. Rails console:
Rails.cache.write('hoang', 'toni')
Rails.cache.fetch('hoang', expires_in: 1.hour) # => "toni"
Rails.cache.read('hoang') # => "toni"

Rails.cache.write('hoang123', 'toni123')
$redis.get('hoang123') # => nil
$redis.get('cache:hoang123') # => "\x00\x11\x02;\xFE-\x97\xA7\x13\xDAA\xFF\xFF\xFF\xFFtoni123"

# 2. Terminal:
# redis-cli -n 2 get cache:hoang123 ==> "\x00\x11\x02;\xfe-\x97\xa7\x13\xdaA\xff\xff\xff\xfftoni123"

# redis-cli -n 2
# 127.0.0.1:6379[2]> keys *

# 3. Clear cache:
$redis.flushall # clear all keys in Redis (include key from Redis + Rails.cache)
Rails.cache.clear # clear all keys from Rails.cache (prefix = cache:)
