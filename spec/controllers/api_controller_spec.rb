require 'rails_helper'

RSpec.describe ApiController, type: :controller do
  controller(ApiController) do
    def index
      render json: { message: 'Hello World' }
    end
  end

  describe "using a jwt token" do
    let(:member) { FactoryBot.create(:member) }

    it "renders access denied if header is missing" do
      get :index
      expect(response.status).to eq 401
      expect(response).to_not be_ok
      expect(response_json).to eq('success' => false, 'message' => 'Access Denied', 'data' => {})
    end

    it "renders forbidden if header is incorrect" do
      request.headers['Authorization'] = 'evil token'
      get :index
      expect(response.status).to eq 403
      expect(response).to_not be_ok
      expect(response_json).to eq('success' => false, 'message' => 'Access is Forbidden', 'data' => {})
    end

    it 'succeeds when token is present and valid' do
      token = member.access_tokens.valid.first.token
      request.headers.merge!({ 'Authorization' => "Bearer #{token}" })
      get :index
      expect(response.status).to eq 200
    end

  end

  describe 'when not logged in' do
    it "requires a logged in user" do
      get :index
      expect(response.status).to eq 401
      expect(JSON.parse(response.body)['message']).to eq 'Access Denied'
    end
  end

end
