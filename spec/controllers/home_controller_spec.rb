require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  it "defaults to not logged in" do
    get :index
    expect(response).to be_ok
  end
end
