require 'rails_helper'

describe 'Tokens API', type: :request do
  let(:member) { FactoryBot.create(:member) }
  let(:other_member) { FactoryBot.create(:member) }
  let!(:token) { member.access_tokens.valid.first }
  let!(:other_token) { other_member.access_tokens.first }
  let(:headers) {
    { "CONTENT_TYPE" => "application/json", 'Authorization' =>  token.token }
  }

  describe 'GET' do
    it "lists tokens" do
      3.times { member.access_tokens.create! }
      get "/api/v1/access_tokens.json", :headers => headers
      expect(response_data[0]['token']).not_to be_empty
      ids = response_data.map{|token|token['id']}
      expect(
        ids
      ).to match_array(member.access_tokens.pluck(:id))
    end

    it 'only includes current members tokens' do
      get "/api/v1/access_tokens.json", :headers => headers
      ids = response_data.map{|t| t['id']}
      expect(ids).not_to include other_token.id
    end
  end

  describe 'POST' do
    it 'creates a token' do
      expect {
        post "/api/v1/access_tokens.json", params: {name: 'test-token' }.to_json, headers: headers
        expect(response_json['success']).to be true
      }.to change {
        member.access_tokens.count
      }.by 1
    end
    it 'cannot forge a member id' do
      expect {
        expect {
          post "/api/v1/access_tokens.json", headers: headers,
               params: {name: 'test-token', member_id: other_member.id }.to_json
        }.to change {
          member.access_tokens.count
        }.by 1
      }.to_not change {
        other_member.access_tokens.count
      }
    end
  end

  describe 'PUT' do
    it 'updates a token' do
      put "/api/v1/access_tokens/#{token.id}",
          params: {name: 'bad-token', is_revoked: true}.to_json, headers: headers
      expect(response_json['success']).to be true
      expect(response.status).to eq 200
      expect(token.reload.as_json).to include('is_revoked' => true, 'name' => 'bad-token')
    end

    it 'cannot update other members tokens' do
      expect {
        put "/api/v1/access_tokens/#{other_token.id}",
            params: {name: 'yo-i-stole-your-token'}.to_json, headers: headers
      }.to_not change {
        other_token.reload.name
      }
      expect(response.status).to eq 404
      expect(response_json['success']).to be false
    end
  end

end
