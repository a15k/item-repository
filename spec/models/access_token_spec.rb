require 'rails_helper'

RSpec.describe AccessToken, type: :model do

  let(:member) { FactoryBot.create :member }
  let(:token) { member.access_tokens.first }

  it 'can encode to jwt and use that for fetching member' do
    jwt = token.token
    expect(jwt).not_to be_empty
    expect(AccessToken.member_for(jwt: jwt)).to eq member
  end
end
