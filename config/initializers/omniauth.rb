OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, "1898283013788070", "2aec77dd54976fd74ac7cc8641c53309", :scope => 'email', :info_fields => 'email, first_name, last_name', :image_size => 'large'
end 