require 'rails_helper'

RSpec.describe Assessment, type: :model do
  it "has working factory" do
    FactoryBot.create :assessment
  end
end
