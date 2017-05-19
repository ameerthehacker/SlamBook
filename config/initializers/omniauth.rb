OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, ENV["FB_APP_ID"], ENV["FB_APP_SECRET"], :scope => 'email', :info_fields => 'email, first_name, last_name', :image_size => 'large'
end 