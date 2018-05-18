require 'rails_helper'

describe 'Tokens API', type: :request do
  let(:member) { FactoryBot.create(:member) }
  let(:authorization) { member.access_tokens.valid.first.token }
  let(:headers) {
    { "CONTENT_TYPE" => "application/json", 'Authorization' =>  authorization }
  }

  it "lists tokens" do
    3.times { member.access_tokens.create! }

    get "/api/v1/access_tokens.json", :headers => headers
    expect(response_data[0]['token']).not_to be_empty
    ids = response_data.map{|token|token['id']}
    expect(
      ids
    ).to match_array(AccessToken.pluck(:id))
   end

  it 'creates a token' do
    expect {
      post "/api/v1/access_tokens.json", params: {name: 'test-token' }.to_json, headers: headers
      expect(response_json['success']).to be true
    }.to change {
      member.access_tokens.count
    }.by 1

  end

end
