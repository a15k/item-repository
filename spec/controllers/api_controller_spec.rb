require 'rails_helper'

RSpec.describe ApiController, type: :controller do
  controller(ApiController) do
    def index
      render json: { message: 'Hello World' }
    end
  end

  describe "with a logged in user" do
    let(:user) { FactoryBot.create(:user) }

    it 'using a jwt token' do
      token = Access::Token.for_user(user)
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
