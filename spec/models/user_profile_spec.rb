require 'rails_helper'

RSpec.describe UserProfile, type: :model do
  it "has working factory" do
    FactoryBot.create :profile
  end
end
