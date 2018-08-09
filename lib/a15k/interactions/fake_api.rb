module A15K

  module Interactions

    module FakeApi
      extend self

      def get_apps(group_id:)
        return [mock_app(SecureRandom.uuid)]
      end

      def create_app(group_id:)
        return mock_app(SecureRandom.uuid)
      end

      def delete_app(id)
        return mock_app(id)
      end

      def update_app(_, app: app)
        app
      end

      def mock_app(group_id)
        { "id": group_id, "api_id":"HLwDJbcYuIk=","api_token":"sti0yiDHyM1S0k3FomGRewSiVbs=","whitelisted_domains":[]}
      end
    end

  end
end
