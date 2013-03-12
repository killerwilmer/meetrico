ActionMailer::Base.smtp_settings = {
  :address              => "localhost",
  :port                 => 25,
  :domain               => "meetrico.com", #meetrico.com
  :authentication       => "plain",
  :enable_starttls_auto => false
}

#if Rails.env.development? || Rails.env.test?
#  ActionMailer::Base.default_url_options[:host] = "http://localhost:80" # localhost:80
#else
#  ActionMailer::Base.default_url_options[:host] = "http://www.meetrico.com" # localhost:80
#end

ActionMailer::Base.default_url_options[:host] = "www.meetrico.com" # localhost:80
