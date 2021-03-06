# config valid only for current version of Capistrano
lock '3.4.0'


################################################################################
# default capistrano
#
set :application, 'lh_fast'
set :repo_url, 'git@bitbucket.org:lendinghedge/lh_fast.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :deploy_to, '/var/www/lh_fast'

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :info

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml','config/application.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/downloads', 'tmp/pids','tmp/cache','tmp/sockets')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5


################################################################################
# capistrano-bundler
#
# set :bundle_roles, :all                                         # this is default
# set :bundle_servers, -> { release_roles(fetch(:bundle_roles)) } # this is default
# set :bundle_binstubs, -> { shared_path.join('bin') }            # default: nil
# set :bundle_gemfile, -> { release_path.join('MyGemfile') }      # default: nil
set :bundle_path, -> { shared_path.join('bundle') }             # this is default
# set :bundle_without, %w{development test}.join(' ')             # this is default
# set :bundle_flags, '--deployment --quiet'                       # this is default
# set :bundle_env_variables, {}                                   # this is default


################################################################################
# capistrano-rbenv
#
set :rbenv_type, :user
set :rbenv_ruby, '2.3.0'
# set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
# set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value


################################################################################
# capistrano-puma
#
set :puma_user, fetch(:user)
set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_default_control_app, "unix://#{shared_path}/tmp/sockets/pumactl.sock"
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_access.log"
set :puma_error_log, "#{shared_path}/log/puma_error.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 16]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, false
set :puma_preload_app, true
set :nginx_use_ssl, false

################################################################################
# capistrano sidekiq
#
# set :sidekiq_default_hooks => true
# set :sidekiq_pid => File.join(shared_path, 'tmp', 'pids', 'sidekiq.pid')
# set :sidekiq_env => fetch(:rack_env, fetch(:rails_env, fetch(:stage)))
# set :sidekiq_log => File.join(shared_path, 'log', 'sidekiq.log')
# set :sidekiq_options => nil
# set :sidekiq_require => nil
# set :sidekiq_tag => nil
# set :sidekiq_config => nil # if you have a config/sidekiq.yml, do not forget to set this.
# set :sidekiq_queue => nil
# set :sidekiq_timeout => 10
# set :sidekiq_role => :app
# set :sidekiq_processes => 1
# set :sidekiq_options_per_process => nil
# set :sidekiq_concurrency => nil
# set :sidekiq_monit_templates_path => 'config/deploy/templates'
# set :sidekiq_monit_use_sudo => true
# set :sidekiq_cmd => "#{fetch(:bundle_cmd, "bundle")} exec sidekiq" # Only for capistrano2.5
# set :sidekiqctl_cmd => "#{fetch(:bundle_cmd, "bundle")} exec sidekiqctl" # Only for capistrano2.5
# set :sidekiq_user => nil #user to run sidekiq as


################################################################################
# default tasks
#
namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end


################################################################################
# slackistrano bot
#
#
set :slack_webhook, "https://hooks.slack.com/services/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"
