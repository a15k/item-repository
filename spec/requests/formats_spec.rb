require "rails_helper"

RSpec.describe "Formats API Request", type: :request do

  let(:user) { FactoryBot.create(:user) }

  it "retrieves all formats" do
    5.times {
      FactoryBot.create :format
    }
    get api_v1_formats_url, headers: { 'Authorization' => "Bearer #{Access::Token.for_user(user)}" }

    expect(response.status).to eq 200
    body = JSON.parse(response.body)
    # This can be DRYED up
    JSON::Validator.validate!('config/schema.json', body)

  end


end
