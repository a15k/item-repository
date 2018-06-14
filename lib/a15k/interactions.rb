require_relative 'interactions/fake_api'

module A15K

  module Interactions

    def self.api(fake: Rails.env.test?)
      @api ||= (
        fake ? FakeApi : A15kInteractions::AppsApi.new
      )
    end

  end
end
