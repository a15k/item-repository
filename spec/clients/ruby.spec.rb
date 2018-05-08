require_relative '../rails_helper'
require 'a15k_client'
require 'rack/test'

describe 'Ruby client', type: :api do

  let(:user) { FactoryBot.create(:user) }
  let(:format) { FactoryBot.create(:format) }
  let(:api_instance) { A15kClient::AssessmentsApi.new }
  let(:authorization) { Access::Token.for_user(user) }

  before(:each) {
    A15kClient.configure do |c|
      c.host = "localhost:#{api_server_port}"
      c.scheme = 'http'
      c.api_key['Authorization'] = authorization
      c.verify_ssl_host = false
    end
  }

  it 'can create an assessment' do
    response = api_instance.create_assessment(
      format_id: format.id,
      identifier: 'TEST-Test-AND-TEST-MORE',
      content: { text: Faker::Lorem.paragraph }.to_json,
      questions: 2.times.map{|question_index|
        {
          format_id: format.id,
          content: {
            index: question_index,
            text: Faker::Lorem.paragraph
          }.to_json,
          solutions: 3.times.map{ |solution_index|
            {
              format_id: format.id,
              content: {
                index: solution_index, text: Faker::Lorem.paragraph
              }.to_json,
            }
          }
        }
      }
    )
    expect(response.success).to eq(true)
    expect(response.data).to be_a_kind_of(A15kClient::Assessment)
    assessment = response.data
    expect(assessment.identifier).to eq('TEST-Test-AND-TEST-MORE')
    expect(assessment.format_id).to eq(format.id)
    expect(assessment.questions.length).to eq(2)
    expect(assessment.questions[0].solutions.length).to eq(3)
  end


end
