module Demo2
  module Utils

    def self.sentence(keyword: nil, question: false, blank: false)
      value = Faker::Lorem.sentence(12, true, 3)
      value[-1] = ''

      if keyword.present? || blank
        words = value.split
        indexes = [*0..words.length-1].shuffle

        if keyword.present?
          keyword_index = indexes.pop
          words[keyword_index] = keyword
        end

        if blank
          blank_index = indexes.pop
          words[blank_index] = "_________"
        end

        value = words.join(" ")
      end

      value.capitalize!
      value + (question ? '? ' : '. ')
    end


  end
end
