require_relative 'metadata/assessment_to_metadata'
require_relative 'metadata/api_result'
require_relative 'metadata/fake_api'
require_relative 'metadata/api'

module A15K

  module Metadata

    def self.api(fake: Rails.env.test?, **args)
        fake ? FakeApi.new(**args) : Api.new(**args)
    end

  end
end
