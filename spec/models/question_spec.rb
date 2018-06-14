require 'rails_helper'

RSpec.describe Question, type: :model do
  it "has working factory" do
    FactoryBot.create :question
  end
end
