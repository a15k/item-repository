module Interactions

  module FakeApi
    extend self

    def get_apps(group_id:)
      return [mock_app(group_id)]
    end

    def create_app(group_id:)
      return mock_app(group_id)
    end

    def delete_app(id)
      return mock_app(id)
    end


    def mock_app(group_id)
      { "id": group_id, "api_id":"HLwDJbcYuIk=","api_token":"sti0yiDHyM1S0k3FomGRewSiVbs=","whitelisted_domains":[]}
    end
  end

end
