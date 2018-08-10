require 'rails_helper'

RSpec.describe User, type: :model do
  it "has working factory" do
    FactoryBot.create :user
  end

  describe 'member info' do
    let(:user) { FactoryBot.create :user, role: 'standard_user' }

    it 'includes name and power users' do
      user1 = FactoryBot.create :user, member: user.member, role: 'power_user'
      expect(user.member_info).to(
        eq(
          member_name: user.member.name,
          member_power_users: [{ name: user1.account.name }],
        )
      )
    end

    it 'only power users reveal token' do
      expect(user.member_info[:token]).to be_nil
      user.update_attributes role: 'power_user'
      expect(user.member_info[:token]).not_to be_nil
    end

  end

  it 'guards against last power user downgrade' do
    member = FactoryBot.create :member
    user1 = FactoryBot.create :user, member: member, role: 'power_user'
    user2 = FactoryBot.create :user, member: member, role: 'power_user'
    user1.update_attributes role: 'standard_user'
    expect(user1.errors.none?).to be true

    user2.update_attributes role: 'standard_user'
    expect(user2.errors[:member]).to eq ['must have at least one power user']
  end

end
