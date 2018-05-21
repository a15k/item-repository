module A15K::Metadata
  class ApiResult
    attr_reader :id, :errors

    def initialize(id, errors = [])
      @errors = errors.freeze
    end

    def ok?
      errors.empty?
    end
  end
end
