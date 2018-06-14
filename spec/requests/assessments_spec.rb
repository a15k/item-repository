require 'rails_helper'

describe 'Assessments API', type: :request do

  let(:authorization) { FactoryBot.create(:member).access_tokens.valid.first.token }
  let(:headers) {
    { "CONTENT_TYPE" => "application/json", 'Authorization' =>  authorization }
  }

  describe 'SEARCH' do
    it "finds assessments" do
      assessment = FactoryBot.create :assessment
      A15K::Metadata.api.create(assessment)
      word = assessment.questions[0].content.split(' ').first
      get "/api/v1/assessments", params: { q: word }, headers: headers
      expect(response).to be_ok
      expect(response_data.length).to eq 1
      expect(response_data.first['id']).to eq assessment.id
    end
  end

  describe 'GET' do

    it "returns an assessment" do
      assessment = FactoryBot.create :assessment
      get "/api/v1/assessments/#{assessment.id}.json", headers: headers
      expect(response).to be_ok
    end

    it "renders not found" do
      get "/api/v1/assessments/1234.json", headers: headers
      expect(response.status).to eq 404
      expect(response).to_not be_ok
      expect(response_json).to eq('success' => false, 'message' => 'Not Found', 'data' => {})
    end

    it "renders forbidden if header is incorrect" do
      headers['Authorization'] = 'evil token'
      get "/api/v1/assessments/1234.json", headers: headers
      expect(response.status).to eq 403
      expect(response).to_not be_ok
      expect(response_json).to eq('success' => false, 'message' => 'Access is Forbidden', 'data' => {})
    end

    it "renders access denied if header is missing" do
      headers.delete('Authorization')
      get "/api/v1/assessments/1234.json", headers: headers
      expect(response.status).to eq 401
      expect(response).to_not be_ok
      expect(response_json).to eq('success' => false, 'message' => 'Access Denied', 'data' => {})
    end
  end

  describe 'POST' do
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

end
