# capistrano
require 'capistrano/setup'

# defaults
require 'capistrano/deploy'

# capistrano extras
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'

# puma
require 'capistrano/puma'
# require 'capistrano/puma/workers' # if you want to control the workers (in cluster mode)
require 'capistrano/puma/jungle'  # if you need the jungle tasks
# require 'capistrano/puma/monit'   # if you need the monit tasks
# require 'capistrano/puma/nginx'   # if you want to upload a nginx site template

# sidekiq
require 'capistrano/sidekiq'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
#Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

require 'slackistrano/capistrano'
