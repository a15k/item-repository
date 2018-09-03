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
      word = assessment.variants[0].content.split(' ').first
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

    let(:metadata) {
      { foo: 'bar', tags: ['first', 'test:true'] }
    }
    let(:params) {
      {
        source_identifier: SecureRandom.uuid,
        content: '1234 this is content',
        metadata: metadata,
        variants: [
          {
            format_id: format.id,
            content: '1234 this is question content',
          }
        ]
      }
    }

    it 'can create an assessment' do
      expect {
        post "/api/v1/assessments.json", params: params.to_json, headers: headers
        expect(response).to be_ok
        expect(response_json['success']).to be true
        expect(response_data['variants'].length).to eq 1
      }.to change {
        Assessment.count
      }.by 1
    end

    it 'saves metadata' do
      metadata_api = A15K::Metadata::FakeApi.new
      expect(metadata_api).to receive(:create)
                                .with(kind_of(Assessment))
                                .and_call_original
      expect(metadata_api).to receive(:create_metadata)
                                 .with(kind_of(Assessment))
      expect(A15K::Metadata).to receive(:api).and_return(metadata_api)
      post "/api/v1/assessments.json", params: params.to_json, headers: headers
      expect(response).to be_ok
    end

    describe "multiple versions" do
      it 'can create multiple versions' do
        id = SecureRandom.uuid
        post "/api/v1/assessments.json", params: {
               source_identifier: id, version: '1',
               variants: [{ format_id: format.id, content: '1st' }]
             }.to_json, headers: headers
        expect(response).to be_ok

        post "/api/v1/assessments.json", params: {
               source_identifier: id, version: '2',
               variants: [{ format_id: format.id, content: '2st' }]
             }.to_json, headers: headers
        expect(response).to be_ok
        expect(Assessment.where(source_identifier: id).count).to eq 2
      end

      it 'fails if one member uses another members a15k_identifier' do
        asm = FactoryBot.create :assessment, source_identifier: '1'
        post "/api/v1/assessments.json", params: {
               a15k_identifier: asm.a15k_identifier, source_version: "whatever",
               variants: [{ format_id: format.id, content: '1st' }]
             }.to_json, headers: headers
        expect(response.status).to eq 422
        expect(response_json['success']).to be false
        expect(response_json['message']).to include 'Member must be the same'
      end

      it 'succeeds if one member uses another members source_identifier' do
        asm = FactoryBot.create :assessment, source_identifier: '1'
        post "/api/v1/assessments.json", params: {
               source_identifier: asm.source_identifier, source_version: "whatever",
               variants: [{ format_id: format.id, content: '1st' }]
             }.to_json, headers: headers
        expect(response.status).to eq 200
      end
    end
    it 'can create a generative assessments' do
      expect {
        post "/api/v1/assessments.json", params: {
               source_identifier: SecureRandom.uuid,
               variants: (1..20).flat_map do |a|
                 (1..10).map do |b|
                   {
                     format_id: format.id,
                     source_identifier: "#{a}-#{b}",
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
        Variant.count
      }.by 200
    end

    it 'accepts variants without source_identifiers' do
        post "/api/v1/assessments.json", params: {
               source_identifier: SecureRandom.uuid,
               variants: [
                 { format_id: format.id, content: '1st' },
                 { format_id: format.id, content: '2nd' },
               ]
             }.to_json, headers: headers
        expect(response.status).to eq 200
    end
  end

end
