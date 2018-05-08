require_relative '../rails_helper'
require 'a15k_client'

describe 'Ruby client' do

  let(:user) { FactoryBot.create(:user) }
  let(:api_instance) { A15kClient::AssessmentsApi.new }
  # let(:headers) { { 'AUTHORIZATION' => Access::Token.for_user(user) } }

  before(:each) {
    A15kClient.configure do |c|
      c.host = 'localhost:4001'
      c.scheme = 'http'
      # c.debugging = true
      c.api_key['Authorization'] = ENV['A15K_AUTH']
      c.verify_ssl_host = false
      c.api_key_prefix['Authorization'] = 'Bearer'
    end
  }

  it 'can create an assessment' do
      questions = exercise.delete('questions')

      ox_format_uuid = "7ec91a74-ff17-4460-9776-1f2fc6b9ce61"

      api_instance.api_v1_assessments_json_post(
        format_id: ox_format_uuid,
        content: JSON.generate(exercise)
        questions: questions.map{|question|
          answers = question.delete('answers')
          {
            format_id: ox_format_uuid,
            content: JSON.generate(question)
            solutions: answers.map{|answer|
              format_id: ox_format_uuid,
              content: JSON.generate(answer)
            }
          }
        }
      )
  end

end
