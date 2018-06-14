module A15K::OpenStax

  module Accounts

    def self.api(fake: OpenStax::Accounts.configuration.enable_stubbing?, **args)
        fake ? FakeApi.new : Api.new
    end

  end
end

require_relative 'accounts/fake_api'
require_relative 'accounts/api'
