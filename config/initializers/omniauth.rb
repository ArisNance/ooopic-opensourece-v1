OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1826336270786308', 'fde241a14c16509cf1ccb12e407fb36c'
end