require 'rails_helper'

describe 'Tokens API', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:member) { user.member }

  let(:authorization) { member.access_tokens.valid.first.token }
  let(:headers) {
    { "CONTENT_TYPE" => "application/json", 'Authorization' =>  authorization }
  }

  describe 'claiming a user account' do

    it "can claim a user" do
      post "/api/v1/users/add", headers: headers,
           params: { email: 'test@test.com', role: 'power_user' }.to_json
      user = User.find(response_data['id'])
      expect(member.users.reload).to include user
      expect(user.reload.member).to eq(member)
      expect(user.power_user?).to be true
      expect(response).to be_ok
      expect(response_json['success']).to be true
    end

    it 'fails when user is already joined to a different membership' do
      post "/api/v1/users/add", headers: headers,
           params: { email: 'test@test.com', role: 'power_user' }.to_json
      expect(response).to be_ok

      other_member = FactoryBot.create(:member)
      headers['Authorization'] = other_member.access_tokens.valid.first.token

      post "/api/v1/users/add", headers: headers,
           params: { email: 'test@test.com', role: 'power_user' }.to_json

      expect(response.status).to eq 422
      expect(response_json['success']).to be false
    end
  end

  it 'can alter a users role' do
    expect{
      put "/api/v1/users/#{user.id}", headers: headers,
          params: { role: 'power_user' }.to_json
    }.to change{ user.reload.role }
           .from('standard_user')
           .to('power_user')
  end

  it 'lists users for a membership' do
    other_user = FactoryBot.create(:user, member: nil)
    get "/api/v1/users.json", headers: headers
    ids = response_data.map{|u| u['id']}
    expect(ids).to include user.id
    expect(ids).not_to include other_user.id
  end

  it 'deletes users by removing the membership' do
    expect{
      delete "/api/v1/users/#{user.id}", headers: headers
    }.to change{ user.reload.member_id }
           .from(user.member_id)
           .to(nil)
  end
end
