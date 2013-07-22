require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Assets should be precompiled for production (so we don't need the gems loaded then)
Bundler.require(:default, Rails.env)

module Raspas
  class Application < Rails::Application
    # config.i18n.default_locale = "pt-BR"
    config.action_mailer.default_url_options = { host: 'raspas.com.br' }
    config.autoload_paths += %W(#{config.root}/presenters)
  end
  # REVISE translations
end
