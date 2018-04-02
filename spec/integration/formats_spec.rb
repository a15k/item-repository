require 'rails_helper'

describe 'Formats API' do
   after do |example|
     example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
   end

  path '/api/v1/formats.json' do


   get 'Retrieves all formats' do
     tags 'Formats'
     security [Token: {}]
     produces 'application/json', 'application/xml'
     #parameter name: :id, :in => :path, :type => :string

     response '200', 'formats returned' do
       schema type: :object,

              required: ['data'],
              properties: {
                data: {
                  type: 'array',
                  items: {
                    title: 'Format',
                    type: 'object',
                    required: %w[id type],
                    properties: {
                      id: { type: :string, format: :uuid },
                      type: { type: :string },
                      attributes: {
                        type: 'object',
                        required: %w[name description],
                        properties: {
                          name: { type: :string },
                          description: { type: :string },
                        }
                      }
                    }
                  }
                }
              }

       let(:user) { FactoryBot.create(:user) }
       let(:Authorization) { Access::Token.for_user(user) }

       before(:each) do
         3.times { FactoryBot.create :format }
       end
       run_test!
     end

     response '401', 'invalid user token' do
       let(:Authorization) { 'blah' }
       run_test!
     end
   end
 end

end
