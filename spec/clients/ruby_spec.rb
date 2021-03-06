require_relative '../rails_helper'
require 'a15k_client'
require 'rack/test'

describe 'Ruby client', type: :api do

  let(:format) { FactoryBot.create(:format) }
  let(:authorization) { FactoryBot.create(:member).access_tokens.first.token }

  before(:each) {
    A15kClient.configure do |c|
      c.scheme = 'http'
      # c.debugging = true
      c.host = "localhost:#{api_server_port}/"
      c.api_key['Authorization'] = authorization
    end
  }

  describe 'Assessments' do
    let(:api_instance) { A15kClient::AssessmentsApi.new }

    it 'can be fetched' do
      assessment = FactoryBot.create(:assessment, format: format)
      response = api_instance.get_assessment(
        assessment.id
      )
      expect(response.success).to eq(true)
      expect(response.data).to be_a_kind_of(A15kClient::Assessment)
    end

    it 'can be created' do
      response = api_instance.create_assessment(
        source_identifier: 'TEST-Test-AND-TEST-MORE',
        content: { text: Faker::Lorem.paragraph }.to_json,
        variants: 2.times.map{|question_index|
          {
            format_id: format.id,
            source_identifier: question_index.to_s,
            content: {
              index: question_index,
              text: Faker::Lorem.paragraph
            }.to_json,
          }
        }
      )
      expect(response.success).to eq(true)
      expect(response.data).to be_a_kind_of(A15kClient::Assessment)
      assessment = response.data
      expect(assessment.source_identifier).to eq('TEST-Test-AND-TEST-MORE')
      expect(assessment.variants.length).to eq(2)
    end

  end

  describe 'Formats' do
    let(:api_instance) { A15kClient::FormatsApi.new }

    it 'can be created' do
      response = api_instance.create_format(
        name: 'test', specification: 'this is an explanation of the format'
      )
      expect(response.success).to eq(true)
      expect(response.data).to be_a_kind_of(A15kClient::Format)
      expect(response.data.as_json).to(
        include(
          'name' => 'test',
          'specification' => 'this is an explanation of the format'
        )
      )
    end

    it 'can be fetched' do
      3.times{ FactoryBot.create(:format) }
      response = api_instance.get_formats
      expect(response.data).to be_a Array
      expect(response.data.length).to be 3
    end
  end

end
