require 'rails_helper'

RSpec.describe Member, type: :model do
  it "has working factory" do
    FactoryBot.create :member
  end
end
