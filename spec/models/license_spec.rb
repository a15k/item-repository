require 'rails_helper'

RSpec.describe License, type: :model do
  it "has working factory" do
    FactoryBot.create :license
  end
end
