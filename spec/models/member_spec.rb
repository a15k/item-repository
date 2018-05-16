require 'rails_helper'

RSpec.describe Member, type: :model do
  it "has working factory" do
    FactoryBot.create :member
  end

  it 'adds token after create' do
    member = Member.create!(name: 'TESTING', website: 'test.test.com')
    expect(member.access_tokens.length).to eq 1
  end
end
