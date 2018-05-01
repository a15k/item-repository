require 'rails_helper'

describe 'Assessments API', type: :request do

  let(:user) { FactoryBot.create(:user) }
  let(:authorization) { Access::Token.for_user(user) }
  let(:headers) {
    { "CONTENT_TYPE" => "application/json", 'Authorization' =>  authorization }
  }

  it "returns an assessment" do
    assessment = FactoryBot.create :assessment
    get "/api/v1/assessments/#{assessment.id}.json", headers: headers
    expect(response).to be_ok
  end

  it 'can create an assessment' do
    format = FactoryBot.create(:format)
    expect {
      post "/api/v1/assessments.json", params: {
             identifier: SecureRandom.uuid,
             content: '1234 this is content',
             format_id: format.id,
             questions: [
               {
                 format_id: format.id,
                 content: '1234 this is question content',
                 solutions: [
                   {
                     format_id: format.id,
                     content: '1234 this is question solution 1'
                   }, {
                     format_id: format.id,
                     content: '1234 this is question solution 2'
                   }
                 ]
               }
             ]
           }.to_json, headers: headers
      expect(response).to be_ok
      expect(response_json['success']).to be true
      expect(response_data['questions'].length).to eq 1
      expect(response_data['questions'][0]['solutions'].length).to eq 2
    }.to change {
      Assessment.count
    }.by 1
  end

end
