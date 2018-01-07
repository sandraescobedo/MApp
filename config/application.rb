require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Mapp
  class Application < Rails::Application
    config.load_defaults 5.1
    config.assets.initialize_on_precompile = false
    config.i18n.default_locale = :es
  end
end
