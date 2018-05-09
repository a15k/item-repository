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
          content: <<~EOC
             How much time do hippos spend in the water each day?

             a) 2 hours
             b) 16 hours
             c) 24 hours

             **answerkey:b**
          EOC,
          solutions: [
            {
              format_id: format.id,
              content: <<~EOC
                a) that seems really low, hippos love water
                b) excellent!
                c) Do they really stay in the water all day long?
              EOC
        }
      ]
    ).data

    fetched = assessments.get_assessment(assessment.id).data
    expect(fetched.questions[0].content).to include 'spend in the water'

  end

end
