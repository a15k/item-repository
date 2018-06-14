require_relative '../rails_helper'
require 'a15k_client'
require 'rack/test'

describe 'complete api flow', type: :api do

  let(:format) { FactoryBot.create(:format) }
  let(:authorization) { FactoryBot.create(:member).access_tokens.valid.first.token }

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
      name: 'plain-text', specification: 'The plain text format uses ascii text'
    ).data

    # double check that the new format is included in the listing
    expect(formats.get_formats.data).to include(format)

    # create a simple assessment using the newly created format
    assessments = A15kClient::AssessmentsApi.new
    assessment = assessments.create_assessment(
      format_id: format.id,
      identifier: 'driving-speed-distance', # must be a unique value
      questions: [
        {
          format_id: format.id,
          solutions: [
            { format_id: format.id, content: "(60 mph)(0.5 hours) = 30 miles" }
          ],
          content: <<~EOC
          A car drives at 60 mph for half an hour.  How far does it travel?

          a) 120 miles
          b) 30 miles
          c) 60 miles

          **answer: b**
          EOC
        }
      ],
      preview_html: <<~EOS
       <div>
         <p>
          A car drives at 60 mph for half an hour.  How far does it travel?
         </p>
         <ul>
          <li>a) 120 miles</li>
          <li>b) 30 miles</li>
          <li>c) 60 miles</li>
         </ul>
       </div>
      EOS
    ).data


    fetched = assessments.get_assessment(assessment.id).data
    expect(fetched.questions[0].content).to include 'drives at 60 mph'
    expect(fetched.preview_html).to include 'drives at 60 mph'
  end

end
