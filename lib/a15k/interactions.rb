require_relative 'interactions/fake_api'

module A15K

  module Interactions

    def self.api(fake: Rails.env.test?)
      @api ||= (
        fake ? FakeApi : A15kInteractions::AppsApi.new
      )
    end

    def self.js_client_path
      spec = Gem::Specification.find_by_name('a15k_interactions_api')
      Pathname.new(spec.gem_dir).join(
        '..', 'javascript', 'dist', 'bundle.js'
      )
    end
  end
end
