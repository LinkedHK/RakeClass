require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)


OmniAuth.config.test_mode = true
OmniAuth.config.add_mock(:facebook,
                         :provider => 'facebook',
                         :uid => '1234567',
                         :info => {
                             :nickname => 'jbloggs',
                             :email => 'joe@bloggs.com',
                             :name => 'Joe Bloggs',
                             :first_name => 'Joe',
                             :last_name => 'Bloggs',
                             :image => 'http://graph.facebook.com/1234567/picture?type=square',
                             :urls => { :Facebook => 'http://www.facebook.com/jbloggs' },
                             :location => 'Palo Alto, California',
                             :verified => true
                         },
                         :credentials => {
                             :token => 'ABCDEF...', # OAuth 2.0 access_token, which you may wish to store
                             :expires_at => 1321747205, # when the access token expires (it always will)
                             :expires => true # this will always be true
                         },
                         :extra => {
                             :raw_info => {
                                 :id => '1234567',
                                 :name => 'Joe Bloggs',
                                 :first_name => 'Joe',
                                 :last_name => 'Bloggs',
                                 :link => 'http://www.facebook.com/jbloggs',
                                 :username => 'jbloggs',
                                 :location => { :id => '123456789', :name => 'Palo Alto, California' },
                                 :gender => 'male',
                                 :email => 'joe@bloggs.com',
                                 :timezone => -8,
                                 :locale => 'en_US',
                                 :verified => true,
                                 :updated_time => '2011-11-11T06:21:03+0000'
                             }
                         })


OmniAuth.config do |config|
  config.on_failure do
    # your handling code invoked in the context of a rack app
  end
end

module Slap
  class Application < Rails::Application


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Asia/Hong_Kong'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.generators do |g|
      g.test_framework :rspec,
                       :fixtures => true,
                       :view_specs => false,
                       :helper_specs => false,
                       :routing_specs => false,
                       :controller_specs => true,
                       :request_specs => true
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end

  config.autoload_paths += %W(
    #{config.root}/app/controllers/concerns
    )
    config.autoload_paths +=  Dir["#{config.root}/app/models/concerns/**/","#{config.root}/lib/**/"]

    config.facebook_app_id  = '1496060750630364'
    config.facebook_secret_app_id = 'd6b3f4bfca4f4c4a6b438ed47342398c'

  end
end
