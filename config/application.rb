require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module LhFast
  class Application < Rails::Application
    # timezone
    config.time_zone = 'UTC'

    # rspec tests automatically generated
    config.generators do |g|
      g.test_framework :rspec, views: false
    end

    # auto load the lib directory
    config.autoload_paths << Rails.root.join('lib')

    config.to_prepare do
      Devise::SessionsController.layout "devise"
      Devise::RegistrationsController.layout proc { |controller| user_signed_in? ? "application" : "devise" }
      Devise::ConfirmationsController.layout "devise"
      Devise::UnlocksController.layout "devise"
      Devise::PasswordsController.layout "devise"
    end

  end
end
