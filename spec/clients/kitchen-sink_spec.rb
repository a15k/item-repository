require_relative '../rails_helper'
require 'a15k_client'
require 'rack/test'

describe 'complete api flow', type: :api do

  let(:user) { FactoryBot.create(:user) }
  let(:format) { FactoryBot.create(:format) }
  let(:authorization) { Access::Token.for_user(user) }

  before(:each) {
    A15kClient.configure do |c|
      c.scheme = 'http'
      c.host = "localhost:#{api_server_port}/"
      c.api_key['Authorization'] = authorization
    end
  }

  it 'can use the api to do useful things' do
    formats = A15kClient::FormatsApi.new

    # create a simple text based format
    format = formats.create_format(
      name: 'plain-text', description: 'The plain text format uses ascii text'
    ).data

    # double check that the new format is included in the listing
    expect(formats.get_formats.data).to include(format)

    # create a simple assessment using the newly created format
    assessments = A15kClient::AssessmentsApi.new
    assessment = assessments.create_assessment(
      format_id: format.id,
      identifier: 'hippo-maddness', # this should be a UUID or something unique
      questions: [
        {
          format_id: format.id,
          content: 'How much time do hippos spend in the water each day?',
          solutions: [
            { format_id: format.id, content: '2 hours'  },
            { format_id: format.id, content: '16 hours' },
            { format_id: format.id, content: '24 hours' },
          ]
        }
      ]
    ).data

    # add a new version of the assessment that has a new question
    assessment = assessments.create_assessment(
      identifier: 'hippo-maddness', # matches id given in first assessment
      version: '2', # this is new
      format_id: format.id,
      questions: [
        assessment.questions[0].to_hash,
        {
          format_id: format.id,
          content: 'A baby hippo is known as a what?',
          solutions: [
            { format_id: format.id, content: 'calf'   },
            { format_id: format.id, content: 'kids'   },
            { format_id: format.id, content: 'colt'   },
            { format_id: format.id, content: 'murder' },
          ]
        }
      ]
    ).data

    expect(assessment.version).to eq('2')

    # test that our assessment now has 2 questions
    expect(assessment.questions.map(&:content)).to(
      include(
        "How much time do hippos spend in the water each day?",
        "A baby hippo is known as a what?"
      )
    )
  end

end
