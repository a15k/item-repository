require 'rails_helper'

RSpec.describe Tag, type: :model do
  it "has working factory" do
    FactoryBot.create :tag
  end
end
