# sidekiq.rb

# global
redis_url = ENV['redis_url']

# server
Sidekiq.configure_server do |config|

  # standard
  config.redis = { url:  redis_url}

  # https://github.com/moove-it/sidekiq-scheduler
  config.on(:startup) do
    if Rails.env.production?
      scheduler_file = Rails.root.join("config/scheduler.yml")
      Sidekiq.schedule = YAML.load_file(scheduler_file)
      Sidekiq::Scheduler.reload_schedule!
    else
      Sidekiq::Scheduler.enabled = false
    end
  end

end

# client
Sidekiq.configure_client do |config|

  # standard
  config.redis = { url:  redis_url}

  # https://github.com/moove-it/sidekiq-scheduler
  Sidekiq::Scheduler.enabled = false
end
