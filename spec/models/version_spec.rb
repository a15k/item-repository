require 'rails_helper'

RSpec.describe Version, type: :model do
  it "has working factory" do
    FactoryBot.create :version
  end
end
