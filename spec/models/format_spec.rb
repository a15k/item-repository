require 'rails_helper'

RSpec.describe Format, type: :model do
  it "has working factory" do
    FactoryBot.create :format
  end
end
