require 'rails_helper'

RSpec.describe Member, type: :model do
  it "has working factory" do
    FactoryBot.create :member
  end

  it 'adds token after create' do
    member = Member.create!(name: 'TESTING', website: 'test.test.com')
    expect(member.access_tokens.length).to eq 1
  end

  it 'guards against last power user removal' do
    member = FactoryBot.create :member
    user1 = FactoryBot.create :user, member: member, role: 'power_user'
    user2 = FactoryBot.create :user, member: member, role: 'power_user'

    member.users.delete user1
    member.save
    expect(member.errors.none?).to be true

    member.users.delete user2
    member.save
    expect(member.errors[:users]).to eq ['must have at least one power user']
  end
end
