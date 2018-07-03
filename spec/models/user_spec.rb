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
end
