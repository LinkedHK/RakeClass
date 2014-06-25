# Be sure to restart your server when you modify this file.

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.application.config.facebook_app_id, Rails.application.config.facebook_secret_app_id,
           :scope => 'email',
           :display => 'popup',
           :image_size => 'large',
           :info_fields => 'id,first_name,last_name'
end