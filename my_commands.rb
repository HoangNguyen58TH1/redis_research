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

# 4. Check key exist?
Rails.cache.exist?('hoang') # --> return boolean

# 5. Comamnd of Rails.cache and $redis
Rails.cache.read(key)
Rails.cache.fetch(key)
Rails.cache.write('van1', 'trang1', expires_in: 20.seconds)
Rails.cache.delete(key)

$redis.get(key)
$redis.set('cache:van3', 'trang3', ex: 2.minutes)
$redis.del(key)

# 6. Check TTL of key:
# Rails.cache.ttl(key) --> NOT work
$redis.ttl('cache:hoang') # ==> 3600 
# > 0 --> seconds còn lại
# - 1 --> key tồn tại những KO có TTL (sống mãi)
# -2 --> key KO tồn tại
