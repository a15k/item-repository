require 'rails_helper'

describe 'Formats API', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:authorization) { Access::Token.for_user(user) }
  let(:headers) {
    { "CONTENT_TYPE" => "application/json", 'Authorization' =>  authorization }
  }

  it "lists formats" do
    3.times { FactoryBot.create :format }
    get "/api/v1/formats.json", :headers => headers
    ids = response_data.map{|format|format['id']}
    expect(
      ids
    ).to match_array(Format.pluck(:id))
   end

  it 'creates a format' do
    expect {
      post "/api/v1/formats.json", params: {name: 'test', specification: 'Test Format' }.to_json, headers: headers
      expect(response_json['success']).to be true
    }.to change {
      Format.count
    }.by 1
  end

end
