require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Rootbot
  # rubocop:disable Style/Documentation
  class Application < Rails::Application
    config.load_defaults 6.1

    # load local environment
    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')

      # rubocop:disable Layout/MultilineMethodCallIndentation
      YAML.safe_load(File.open(env_file)).each { |key, value| ENV[key.to_s] = value } if File
        .exist?(env_file)
    end
  end
end
