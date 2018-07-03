require_relative 'interactions/fake_api'

module A15K

  module Interactions

    def self.api(stub: Rails.application.secrets.interactions_api[:stub])
      @api ||= (
        stub ? FakeApi : A15kInteractions::AppsApi.new
      )
    end

  end
end
