module A15K::Metadata

  class QueryResult

    attr_accessor :assessments, :total_count

    def initialize
      @assessments = []
      @total_count = 0
    end

    def as_hash
      @assessments.index_by(&:id)
    end
  end

end
