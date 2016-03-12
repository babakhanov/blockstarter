require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Colaapp
  class Application < Rails::Application
    env_filename = File.exist?(Rails.root.join(".env.#{Rails.env}")) ? ".env.#{Rails.env}" : ".env"
    Dotenv.load Rails.root.join(env_filename)
    config.autoload_paths << Rails.root.join('services')
    config.active_record.raise_in_transactional_callbacks = true
  end
end
