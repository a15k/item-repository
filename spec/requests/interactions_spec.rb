require 'rails_helper'

describe 'Interactions API' do
  let(:user) { FactoryBot.create(:user) }
  let(:headers) { { 'AUTHORIZATION' => Access::Token.for_user(user) } }

  it "lists available interactions" do
    get "/api/interactions", headers: headers
    expect(response).to be_ok
    expect(response_data).to_not be_empty
  end

  it "can create an interaction app" do
    post "/api/interactions", headers: headers
    expect(response).to be_ok
    expect(response_data).to_not be_empty
  end

  it "can delete an app" do
    delete "/api/interactions/133.json", headers: headers
    expect(response).to be_no_content
  end

end
