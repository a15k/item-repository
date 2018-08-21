require_relative 'utils'

module Demo2
  class MemberB

    PHYSICS_KEYWORDS = ['acceleration', 'vector', 'mass']

    attr_reader :member

    def initialize(member_name:)
      @member = Member.create(name: member_name, website: Faker::Internet.url(nil, '/'))
    end

    MC_TEMPLATE = ERB.new(Pathname.new(__FILE__).dirname.join('member_b_mc.html.erb').read)

    def generate_multiple_choice(keyword: nil, tags: [])
      correct_index = [*0..3].shuffle.sample
      question_content = {
        stimulus: Demo2::Utils.sentence +
              Demo2::Utils.sentence(question: true, keyword: keyword || PHYSICS_KEYWORDS.sample),
        answers: 4.times.map do |ii|
          {
            content: Demo2::Utils.sentence,
            correct: ii == correct_index ? true : false
          }
        end
      }

      solution = Demo2::Utils.sentence

      Assessment.create(
        questions: [
          Question.new(
            format_id: multiple_choice_format.id,
            content: question_content.to_xml(root: "question"),
            solutions: [
              Solution.new(
                format_id: plain_text_format.id,
                content: solution,
                member: member
              )
            ]
          )
        ],
        preview_html: MC_TEMPLATE.result(binding),
        member: member
      )
    end

    FITB_TEMPLATE = ERB.new(Pathname.new(__FILE__).dirname.join('member_b_fitb.html.erb').read)

    def generate_fill_in_the_blank(keyword: nil, tags: [])
      question_content = {
        stimulus: Demo2::Utils.sentence(keyword: keyword || PHYSICS_KEYWORDS.sample, blank: true),
      }

      solution = Faker::Lorem.word

      Assessment.create(
        questions: [
          Question.new(
            format_id: fill_in_the_blank_format.id,
            content: question_content.to_xml(root: "question"),
            solutions: [
              Solution.new(
                format_id: plain_text_format.id,
                content: solution,
                member: member
              )
            ]
          )
        ],
        preview_html: FITB_TEMPLATE.result(binding),
        member: member
      )
    end

    SHORT_TEMPLATE = ERB.new(Pathname.new(__FILE__).dirname.join('member_b_short.html.erb').read)

    def generate_short_answer(keyword: nil, tags: [])
      question_content = {
        stimulus: Demo2::Utils.sentence(keyword: keyword || PHYSICS_KEYWORDS.sample, question: true),
      }

      solution = Demo2::Utils.sentence

      Assessment.create(
        questions: [
          Question.new(
            format_id: fill_in_the_blank_format.id,
            content: question_content.to_xml(root: "question"),
            solutions: [
              Solution.new(
                format_id: plain_text_format.id,
                content: solution,
                member: member
              )
            ]
          )
        ],
        preview_html: SHORT_TEMPLATE.result(binding),
        member: member
      )
    end

    def multiple_choice_format
      identifier = "mult choice 1"
      Format.find_by(identifier: identifier) || Format.create!(
        identifier: identifier,
        name: member.name + " multiple choice",
        specification: "A document that describes all you need to know about #{member.name}'s multiple choice data format.",
        created_by: member
      )
    end

    def fill_in_the_blank_format
      identifier = "blanks 3"
      Format.find_by(identifier: identifier) || Format.create!(
        identifier: identifier,
        name: member.name + " fill-in-the-blank",
        specification: "A document that describes all you need to know about #{member.name}'s fill-in-the-blank data format.",
        created_by: member
      )
    end

    def short_answer_format
      identifier = "short answer 2"
      Format.find_by(identifier: identifier) || Format.create!(
        identifier: identifier,
        name: member.name + " short answer",
        specification: "A document that describes all you need to know about #{member.name}'s short answer data format.",
        created_by: member
      )
    end

    def plain_text_format
      identifier = "plain"
      Format.find_by(identifier: identifier) || Format.create!(
        identifier: identifier,
        name: member.name + " plain text",
        specification: "A document that describes all you need to know about #{member.name}'s plain text data format.",
        created_by: member
      )
    end

    def nl2br(text)
      text.gsub("\n", '<br>')
    end

    def style
      <<~STYLE
        <style type="text/css">
          .tp-assessment {
            font-family: 'Arial'
          }
        </style>
      STYLE
    end

  end

end
