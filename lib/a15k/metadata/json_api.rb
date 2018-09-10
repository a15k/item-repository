module A15K::Metadata
  class JsonApi

    class MetadataPaginator < JsonApiClient::Paginating::Paginator
      self.page_param = 'number'
      self.per_page_param = 'size'
    end

    class Model < JsonApiClient::Resource
      # set the api base url in an abstract base class
      self.site = "#{Rails.application.secrets.metadata_api[:url]}/api"
      self.paginator = MetadataPaginator
      # identical to table_name, but singular
      def self.type
        route_formatter.format(resource_name.singularize)
      end

      def self.custom_headers
        super.merge(
          'Authorization' => Rails.application.secrets.metadata_api[:token],
          'Accept' => 'application/vnd.api.metadata.a15k.org+json; version=1',
          'content_type' => 'application/json'
        )
      end

    end

    class Format < Model
    end

    class ApplicationUser < Model
    end

    class Application < Model
    end

    class Resource < Model
      has_one :format
      has_one :application
      has_one :application_user
      has_many :metadatas
    end

    class Metadatas < Model
      has_one :application
      belongs_to :resource
    end

    class Metadatum < Model
      has_one :application
      belongs_to :resource
    end

  end
end
