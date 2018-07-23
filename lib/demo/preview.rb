require 'erb'

class Demo
  class Preview
    TEMPLATE = ERB.new(Pathname.new(__FILE__).dirname.join('preview.html.erb').read)
    attr_reader :solutions, :question, :correct_solution

    def initialize(question, solutions, correct_solution)
      @question = question
      @solutions = solutions
      @correct_solution = correct_solution
    end

    def generate
      TEMPLATE.result(binding)
    end

    def nl2br(text)
      text.gsub("\n", '<br>')
    end
  end
end
