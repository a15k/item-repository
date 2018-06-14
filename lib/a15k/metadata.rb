require_relative 'metadata/assessment_to_metadata'
require_relative 'metadata/api_result'
require_relative 'metadata/fake_api'
require_relative 'metadata/api'

module A15K

  module Metadata

    def self.api(fake: Rails.env.test?)
      fake ? FakeApi.new : Api.new
    end

  end
end
