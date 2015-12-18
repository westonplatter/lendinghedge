# sidekiq.rb

# global
redis_url = ENV['redis_url']

# server
Sidekiq.configure_server do |config|
  config.redis = { url:  redis_url}
end

# client
Sidekiq.configure_client do |config|
  config.redis = { url:  redis_url}
end
