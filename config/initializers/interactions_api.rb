require 'interactions/fake_api'

secrets = Rails.application.secrets.interactions_api

A15kInteractions.configure do |config|
  config.host = secrets[:url]
  config.api_key['X-API-TOKEN'] = secrets[:api_key]
  config.scheme = Rails.env.production? ? 'https' : 'http'
  config.debugging = !Rails.env.production?
end
