require 'rails_helper'

describe 'Tokens API', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:member) { user.member }

  let(:other_user) { FactoryBot.create(:user) }
  let(:other_member) { other_user.member }

  let(:authorization) { member.access_tokens.valid.first.token }
  let(:headers) {
    { "CONTENT_TYPE" => "application/json", 'Authorization' =>  authorization }
  }

  describe 'inviting a user' do

    it "can invite by using a new email" do
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

  describe 'updating a user' do
    it 'can alter a users role' do
      # must have at least one other power user
      FactoryBot.create(:user, member: user.member, role: 'power_user')
      expect{
        put "/api/v1/users/#{user.id}", headers: headers,
            params: { role: 'standard_user' }.to_json
      }.to change{ user.reload.role }
             .from('power_user')
             .to('standard_user')
    end

    it 'can only alter users for the current membership' do
      expect{
        put "/api/v1/users/#{other_user.id}", headers: headers,
            params: { role: 'power_user' }.to_json
        expect(response.status).to eq 403
      }.not_to change{ other_user.reload.role }
    end
  end

  describe 'listing users' do
    it 'lists users for a membership' do
      other_user = FactoryBot.create(:user, member: nil)
      get "/api/v1/users.json", headers: headers
      ids = response_data.map{|u| u['id']}
      expect(ids).to include user.id
      expect(ids).not_to include other_user.id
    end
  end

  describe 'delete' do
    it 'wont delete the last power user' do
      delete "/api/v1/users/#{user.id}", headers: headers
      expect(response.status).to eq 422
      expect(response_json['success']).to be false
    end

    it 'deletes users by removing the membership' do
      # must have another power user
      FactoryBot.create(:user, member: user.member, role: 'power_user')
      expect{
        delete "/api/v1/users/#{user.id}", headers: headers
      }.to change{ user.reload.member_id }
             .from(user.member_id)
             .to(nil)
    end

    it 'can only delete own users' do
      expect{
        delete "/api/v1/users/#{other_user.id}", headers: headers
        expect(response.status).to eq 403
      }.not_to change{ other_user.reload.member_id }
    end

  end
end
