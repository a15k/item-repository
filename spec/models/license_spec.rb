require 'rails_helper'

RSpec.describe License, type: :model do
  it "has working factory" do
    FactoryBot.create :license
  end

  it "can't be udpated" do
    license = FactoryBot.create :license
    license.terms = 'you hereby agree to reliquish your first-born to the lord of darkness'
    expect{ license.save }.to raise_error(ActiveRecord::ReadOnlyRecord)
  end
end
