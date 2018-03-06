require 'rails_helper'

RSpec.describe User, type: :model do
  it "has working factory" do
    FactoryBot.create :user
  end
end
