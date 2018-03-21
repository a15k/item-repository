require 'rails_helper'

RSpec.describe Solution, type: :model do
  it "has working factory" do
    FactoryBot.create :solution
  end
end
