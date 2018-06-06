require 'a15k'

secrets = Rails.application.secrets.interactions_api

A15kInteractions.configure do |config|
  config.host = secrets[:url]
  config.api_key['Authorization'] = "Token #{secrets[:admin_api_token]}"
  config.scheme = secrets[:scheme]
  config.debugging = !Rails.env.production?
end
