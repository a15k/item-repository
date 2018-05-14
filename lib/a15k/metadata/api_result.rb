module A15K::Metadata
  class ApiResult
    attr_reader :errors

    def initialize(errors = [])
      @errors = errors.freeze
    end

    def ok?
      errors.empty?
    end
  end
end
