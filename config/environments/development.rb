Metrocubico::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  #config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  #config.action_mailer.default_url_options = { :host => 'mail.meetrico.com' }
  # correo: admin@lapapaya.org
  # Barcelona01

  #dafeva_1314909478_biz_api1.gmail.com
  #1314909524

  #admin_api1.lapapaya.org
  config.after_initialize do
    ActiveMerchant::Billing::Base.mode = :production
    paypal_options = {
        :login => "admin_api1.lapapaya.org",
        :password => "HCFQTZT877AECKVV",
        :signature => "An5ns1Kso7MWUdW4ErQKJJJ4qi4-AmJiP.20i2agkV1EJpfPHM3DAEtG"
    }
    ::STANDARD_GATEWAY = ActiveMerchant::Billing::PaypalGateway.new(paypal_options)
    ::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
  end

#  config.after_initialize do
#    ActiveMerchant::Billing::Base.mode = :test
#    paypal_options = {
#      :login => "dafeva_1314909478_biz_api1.gmail.com",
#      :password => "1314909524",
#      :signature => "An5ns1Kso7MWUdW4ErQKJJJ4qi4-AznSoyEaMSzqWO.zYR15hsk1zUPx"
#    }
#    ::STANDARD_GATEWAY = ActiveMerchant::Billing::PaypalGateway.new(paypal_options)
#    ::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
#  end

# Specifies the header that your server uses for sending files
#config.action_dispatch.x_sendfile_header = "X-Sendfile"
  config.time_zone = 'Madrid'
  config.active_record.default_timezone = :local

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

end
