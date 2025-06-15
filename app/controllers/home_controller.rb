class HomeController < ApplicationController
  def index
    @cached_value = Rails.cache.fetch('hoang_toni', expires_in: 1.hour) do
      # This block will only be executed if the cache is empty
      "This is a cached value generated at #{Time.current}"
    end

    @redis_value = $redis.get('hoang_toni') || begin
      value = "Hoang Toni 11 at #{Time.current}"
      $redis.set('hoang_toni', value, ex: 3600) # expires in 1 hour
      value
    end
  end
end
