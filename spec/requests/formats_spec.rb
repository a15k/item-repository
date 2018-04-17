require 'rails_helper'

describe 'Formats API' do
   after do |example|
     example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
   end

  path '/api/v1/formats.json' do

   get 'Retrieves all formats' do
     tags 'Formats'
     security [token: []]
     produces 'application/json'

     response '200', 'formats returned' do
       schema json_api_list_schema(Format)

       let(:user) { FactoryBot.create(:user) }
       let(:Authorization) { Access::Token.for_user(user) }


       3.times { FactoryBot.create :format }

       run_test!
     end

     response '401', 'invalid user token' do
       let(:Authorization) { 'blah' }
       run_test!
     end
   end
 end

end
