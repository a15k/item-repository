require 'yaml'
require_relative 'demo/preview'

class Demo

  DATA = YAML.load Rails.root.join('db', 'demo.yml').read

  attr_accessor :member

  def initialize(member: nil)
    @member = member
  end

  def format_id
    @format ||= ( Format.find_by(identifier: 'text') || Format.create!(
                    identifier: 'text', name: 'Plain Text',
                    specification: 'Plain ascii text',
                    created_by: member,
                  )
                )
    @format.id
  end

  def select_unused_question
    question = DATA['questions'].sample
    DATA['questions'].length.times do
      return question unless Variant.where(content: question).exists?
      question = DATA['questions'].sample
    end
    raise("Failed to find question that wasn't in use")
  end

  def create_assessment(solutions_count: 4)
    question = select_unused_question
    solutions = DATA['solutions'].sample(solutions_count)
    assessment = Assessment.create(
      member: member,
      metadata: {
        tags: DATA['tags'].sample(rand(1..4)),
      },
      variants: [
        Variant.new(
          format_id: format_id,
          content: question,
          preview_html: Preview.new(question, solutions, solutions.sample).generate
        )
      ]
    )
    assessment
  end

end
