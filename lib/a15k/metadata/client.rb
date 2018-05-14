module A15K
  module Metadata
    module Client

      class Model < JsonApiClient::Resource
        # set the api base url in an abstract base class
        self.site = Rails.application.secrets.metadata_api[:url]
      end

      class Metadata < MetadataModel

      end
    end

  end
end
