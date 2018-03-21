require 'rails_helper'

RSpec.describe Asset, type: :model do
  it "has working factory" do
    FactoryBot.create :asset, :for_solution
  end
end
