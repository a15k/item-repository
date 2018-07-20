require 'rails_helper'

describe 'Assessments API', type: :request do

  let(:authorization) { FactoryBot.create(:member).access_tokens.first.token }
  let(:headers) {
    { "CONTENT_TYPE" => "application/json", 'Authorization' =>  authorization }
  }
  let(:format) { FactoryBot.create(:format) }

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
      expect {
        post "/api/v1/assessments.json", params: {
               identifier: SecureRandom.uuid,
               content: '1234 this is content',
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

    describe "multiple versions" do
      it 'can create multiple versions' do
        id = SecureRandom.uuid
        post "/api/v1/assessments.json", params: {
               identifier: id, version: '1',
               questions: [{ format_id: format.id, content: '1st' }]
             }.to_json, headers: headers
        expect(response).to be_ok

        post "/api/v1/assessments.json", params: {
               identifier: id, version: '2',
               questions: [{ format_id: format.id, content: '1st' }]
             }.to_json, headers: headers
        expect(response).to be_ok
        expect(Assessment.where(identifier: id).count).to eq 2
      end

      it 'fails if member is different' do
        asm = FactoryBot.create :assessment, identifier: '1'
        post "/api/v1/assessments.json", params: {
               identifier: asm.identifier, version: asm.version,
               questions: [{ format_id: format.id, content: '1st' }]
             }.to_json, headers: headers
        expect(response.status).to eq 422
        expect(response_json['success']).to be false
        expect(response_json['message']).to include 'Member must be the same'
      end
    end
    it 'can create a generative assessments' do
      expect {
        post "/api/v1/assessments.json", params: {
               identifier: SecureRandom.uuid,
               questions: (1..20).flat_map do |a|
                 (1..10).map do |b|
                   {
                     format_id: format.id,
                     variant_id: "#{a}-#{b}",
                     content: <<~EOQ
                     <question>
                       What is the length of the hypotenuse for a right
                       triangle with the other sides #{a} and #{b} inches?
                     </question>
                     <answer>{a**2 + b**2}</answer>
                   EOQ
                   }
                 end
               end
             }.to_json, headers: headers
      }.to change {
        Question.count
      }.by 200
    end

    it 'errors when variants are not correct' do
        post "/api/v1/assessments.json", params: {
               identifier: SecureRandom.uuid,
               questions: [
                 { format_id: format.id, content: '1st' },
                 { format_id: format.id, content: '2nd' },
               ]
             }.to_json, headers: headers
        expect(response.status).to eq 422
        expect(response_json['success']).to be false
        expect(response_json['message']).to include 'Questions'
    end
  end

end
