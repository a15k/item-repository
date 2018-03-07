require 'rails_helper'

RSpec.describe GraphqlController, type: :controller do

  describe "with a logged in user" do

    let(:user) { FactoryBot.create(:user) }

    it 'using a cookie' do
      # TODO: figure out how to make a session cookie
    end

    it 'using a jwt token' do
      token = Access::Token.for_user(user)
      request.headers.merge!({ 'Authorization' => "Bearer #{token}" })
      get :execute
      expect(response.status).to eq 200
    end

  end

  describe 'when not logged in' do
    it "requires a logged in user" do
      get :execute
      expect(response.status).to eq 401
      expect(JSON.parse(response.body)['message']).to eq 'Access Denied'
    end
  end

end
