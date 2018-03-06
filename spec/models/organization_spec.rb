require 'rails_helper'

RSpec.describe Organization, type: :model do
  it "has working factory" do
    FactoryBot.create :organization
  end
end
