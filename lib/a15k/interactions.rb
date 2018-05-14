require_relative 'interactions/fake_api'

module A15K

  module Interactions

    def self.api
      @api ||= (
        Rails.env.test? ? FakeApi : A15kInteractions::AppsApi.new
      )
    end

  end
end
