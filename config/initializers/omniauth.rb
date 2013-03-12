module OmniAuth
  module Strategies
  end
end


Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['METROCUBIC_FACEBOOK_API_KEY'], ENV['METROCUBIC_FACEBOOK_API_SECRET'], :setup => true
end

#{"METROCUBIC_FACEBOOK_API_KEY"=>"201396719891887",
#"INLINEDIR"=>"/app/tmp/home/inline/",
#"APP_ROOT"=>"/app/",
#"TMPDIR"=>"/app/tmp/",
#"SENDGRID_USERNAME"=>"app439882@heroku.com",
#"APP_NAME"=>"metrocubico",
#"BUNDLE_WITHOUT"=>"development:test",
#"RACK_ENV"=>"production",
#"HEROKU_UPID"=>"5009193",
#"PATH"=>"/app/.bundle/gems/ruby/1.8/bin:/usr/ruby1.8.7/bin:/usr/local/bin:/usr/bin:/bin",
#"PWD"=>"/app",
#"PS"=>"web.1",
#"SENDGRID_DOMAIN"=>"heroku.com",
#"TZ"=>"Europe/Madrid",
#"MERB_ENV"=>"production",
#"STACK"=>"bamboo-ree-1.8.7",
#"CONSOLE_AUTH"=>"app439882:IReNTAnUO6FeML4",
#"URL"=>"metrocubico.heroku.com",
#"SHLVL"=>"1",
#"HOME"=>"/app/tmp/home/",
#"HEROKU_SLUG"=>"439882_e0592b0_4fc2",
#"COMMIT_HASH"=>"e0592b0",
#"SENDGRID_PASSWORD"=>"e88fe65ee9038df9f2",
#"RAILS_ENV"=>"production",
#"HEROKU_RACK"=>"/home/heroku_rack/heroku.ru",
#"GEM_PATH"=>"",
#"METROCUBIC_FACEBOOK_API_SECRET"=>"a140af5b63fedc77d56a7c8d6f2ca6db",
#"SHARED_DATABASE_URL"=>"postgres://rkdfypuzuw:ZHt0YBDHuHdIlyOFyWmA@ec2-50-16-205-219.compute-1.amazonaws.com/rkdfypuzuw",
#"SCHEMA"=>"/app/tmp/schema.rb",
#"RUBYOPT"=>"-I/usr/ruby1.8.7/lib/ruby/gems/1.8/gems/bundler-1.0.7/lib -rbundler/setup -r/usr/local/nobuffer ",
#"LAST_GIT_BY"=>"dafevara@gmail.com",
#"HEROKU_TYPE"=>"Dyno",
#"RUBYLIB"=>"/usr/local/pg/ree-1.8.7/lib",
#"DATABASE_URL"=>"postgres://rkdfypuzuw:ZHt0YBDHuHdIlyOFyWmA@ec2-50-16-205-219.compute-1.amazonaws.com/rkdfypuzuw",
#"HEROKU_PORT"=>"51218", "_"=>"/usr/ruby1.8.7/bin/thin",
#"BUNDLE_GEMFILE"=>"/app/Gemfile",
#"GEM_HOME"=>"/app/.bundle/gems/ruby/1.8",
#"BUNDLE_BIN_PATH"=>"/usr/ruby1.8.7/lib/ruby/gems/1.8/gems/bundler-1.0.7/bin/bundle"}
