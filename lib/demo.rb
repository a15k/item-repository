require 'yaml'
require_relative 'demo/preview'

class Demo

  DATA = YAML.load Rails.root.join('db', 'demo.yml').read

  attr_accessor :member

  def format_id
    @format ||= ( Format.find_by(identifier: 'text') || Format.create!(
                    identifier: 'text', name: 'Plain Text',
                    specification: 'Plain ascii text',
                    created_by: member,
                  )
                )
    @format.id
  end

  def create_assessment(solutions_count: 4)
    question = DATA['questions'].sample
    solutions = DATA['solutions'].sample(solutions_count)
    Assessment.create(
      preview_html: Preview.new(question, solutions, solutions.sample).generate,
      member: member,
      questions: [
        Question.new(format_id: format_id, content: question)
      ]
    )
  end

end
