require_relative 'metadata/api_result'
require_relative 'metadata/fake_api'
require_relative 'metadata/api'

module A15K

  module Metadata

    def self.api
      @api ||= (
        Rails.env.test? ? FakeApi.new : Api.new
      )
    end

  end
end
