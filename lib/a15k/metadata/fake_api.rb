module A15K::Metadata
  class FakeApi

    def initialize(user:)
      @user = user
    end

    def add_assessment(assessment)
      return ApiResult.new
    end

  end
end
