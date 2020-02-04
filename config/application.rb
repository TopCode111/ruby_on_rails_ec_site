require_relative 'boot'
require './app/admin/common_item'
require './app/admin/common_seller'
require './app/admin/common_item_comment'
require 'rails/all'
require 'fog/aws'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Pickofficial
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    # set default locale
    config.i18n.default_locale = :ja
    config.i18n.enforce_available_locales = true

    config.active_job.queue_adapter = :delayed_job

    config.assets.precompile += ["en", "ja"].map { |l| "parsley.i18n.#{l}.js" }
    config.exceptions_app = self.routes
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
