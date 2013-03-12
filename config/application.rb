require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require *Rails.groups(:assets => %w(development test))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Metrocubico
  class Application < Rails::Application

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # prueba ahora con clone 5
    config.time_zone = 'Madrid'
    config.active_record.default_timezone = :local
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :es

    # JavaScript files you want as :defaults (application.gallery_view is always included).
    # config.action_view.javascript_expansions[:defaults] = %w(jquery rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    config.salt_and_pepper = "d4e47fdbb1501342aca062d9fb3e1589c7feb224"

    #config.action_dispatch.x_sendfile_header = "X-Sendfile"
    #config.action_mailer.default_url_options = { :host => 'meetrico.com' }
    #config.action_mailer.raise_delivery_errors = true
    #config.action_mailer.delivery_method = :smtp #:sendmail

    #    config.after_initialize do
    #      ActiveMerchant::Billing::Base.mode = :production
    #      paypal_options = {
    #        :login => "admin_api1.lapapaya.org",
    #        :password => "HCFQTZT877AECKVV",
    #        :signature => "An5ns1Kso7MWUdW4ErQKJJJ4qi4-AmJiP.20i2agkV1EJpfPHM3DAEtG"
    #      }
    #      ::STANDARD_GATEWAY = ActiveMerchant::Billing::PaypalGateway.new(paypal_options)
    #      ::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
    #    end

    # Enable the asset pipeline
    config.assets.enabled = true
    config.assets.paths << "#{Rails.root}/app/assets/fonts"
    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

  end
end
