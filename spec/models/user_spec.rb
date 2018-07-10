require 'rails_helper'

RSpec.describe User, type: :model do
  it "has working factory" do
    FactoryBot.create :user
  end

  it 'only power users reveal token' do
    user = FactoryBot.create :user, role: 'standard_user'
    expect(user.membership_access_token).to be_nil
    user.update_attributes role: 'power_user'
    expect(user.membership_access_token).not_to be_nil
  end

  it 'guards against last power user removal' do
    member = FactoryBot.create :member
    user1 = FactoryBot.create :user, member: member, role: 'power_user'
    user2 = FactoryBot.create :user, member: member, role: 'power_user'
    user1.update_attributes role: 'standard_user'
    expect(user1.errors.none?).to be true

    user2.update_attributes role: 'standard_user'
    expect(user2.errors[:member]).to eq ['must have at least one power user']

    user2.update_attributes role: 'power_user'
    expect(user2.errors.none?).to be true
    user2.update_attributes member: nil
    expect(user2.errors[:member]).to eq ['must have at least one power user']
  end

end
