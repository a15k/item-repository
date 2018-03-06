require 'rails_helper'

RSpec.describe Translator, type: :model do
  it "has working factory" do
    FactoryBot.create :translator
  end
end
