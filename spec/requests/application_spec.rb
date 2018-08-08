require 'rails_helper'

describe 'Loading application', type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe 'when not logged in' do
    it 'shows link to login' do
      get "/"
      expect(response.body).to include 'href="/accounts/login"'
    end
  end

  describe 'when logged in but no member' do
    it 'renders without any member info' do
      user.update_attributes(member_id: nil)
      stub_current_user user
      get "/"
      expect(response.body).to include '"member_id":null'
      expect(response.body).to include '"member_name":""'
    end
  end

  describe 'when logged in and has member' do
    it 'renders with member info' do
      stub_current_user user
      get "/"
      expect(response.body).to include "member_id\":\"#{user.member_id}"
      expect(response.body).to include "member_name\":\"#{user.member.name}"
    end
  end

end
