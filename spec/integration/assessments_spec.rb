describe 'Assessments API' do

   let(:user) { FactoryBot.create(:user) }
   let(:format) { FactoryBot.create :format }
   let(:Authorization) { Access::Token.for_user(user) }

   path '/api/v1/assessments/{id}.json' do
     get 'Retrieves an assessment' do
       tags 'Assessments'
       security [token: []]
       produces 'application/json'
       parameter name: :id, in: :path, type: :string
       response '200', 'a assessment is returned' do

         schema type: :object,
                required: ['data', 'included'],
                properties: {
                  data: {
                    type: 'object',
                    required: ['id', 'type', 'attributes'],
                    properties: {
                      id: { type: :string, format: :uuid },
                      type: { type: :string, enum: ['assessment'] },
                      attributes: {
                        type: 'object',
                        required: ['version', 'visibility', 'created_at'],
                        properties: {
                          version: { type: :string },
                          created_at: { type: :string, format: :date },
                          visibility: {
                            type: :string, enum: ['internal', 'external' ]
                          },
                          contents: { type: :string }
                        }
                      }
                    }
                  },
                  included: {
                    type: 'array',
                    items: {
                      type: 'object',
                      required: ['id', 'type', 'attributes'],
                      properties: {
                        id: { type: :string, format: :uuid },
                        type: { type: :string, enum: ['question', 'solution'] },
                        attributes: {
                          type: 'object',
                          required: ['content', 'created_at', 'format_id'],
                          content: { type: :string },
                          created_at: { type: :string, format: :date },
                          format_id: { type: :string, format: :uuid },
                          varient: { type: :string, nullable: true },
                        },
                        relationships: {
                          type: 'object',
                          data: {
                            type: 'array',
                            items: {
                              type: 'object',
                              attributes: {
                                type: { type: :string, enum: ['asset', 'question', 'solution'] },
                                id: { type: :string, format: :uuid },
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }


         let(:user) { FactoryBot.create(:user) }
         let(:Authorization) { Access::Token.for_user(user) }

         let(:assessment) { FactoryBot.create :assessment }

         # after do |example|
         #   example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
         # end
#         p metadata.keys

         let(:id) { assessment.id }
         run_test! do|resp|
           #puts JSON.pretty_generate JSON.parse(resp.body), indent: '    '
         end

   # after do |example|
   #   example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
   # end

       end

     end

   end

   path '/api/v1/assessments.json' do

     post 'create an assessment' do

       tags 'Assessments'
       security [token: []]
       consumes 'application/json'
       produces 'application/json'
       parameter name: :assessment,
                 in: :body,
                 schema: {
                   type: 'object',
                   required: ['data'],
                   properties: {
                     data: {
                       type: 'object',
                       required: ['type', 'attributes'],
                       properties: {
                         attributes: {
                           format_id: { type: :string, format: :uuid },
                           content: { type: :string }
                         }
                       }
                     }
                   }
                 }


       response '201', 'an assessment is created' do
         let(:assessment) {
           {
             data: {
               attributes: {
                 format_id: format.id,
                 content: Faker::Lorem.sentence,
               },
               relationships: {
                 questions: {
                   data: [
                     {
                       type: 'question',
                       attributes: {
                         format_id: format.id,
                         content: Faker::Lorem.sentence
                       },
                       relationships: {
                         solutions: {
                           data: 3.times.map{
                             {
                               type: 'solution',
                               attributes: {
                                 format_id: format.id,
                                 content: Faker::Lorem.sentence
                               }
                             }
                           }
                         }
                       }
                     }
                   ]
                 }
               }
             }
           }
         }


        # example assessment
         run_test! do |resp|
           #example assessment
           #puts JSON.pretty_generate JSON.parse(resp.body), indent: '    '
         end

         after do |example|
           #           debugger

           example.metadata[:response][:examples] = {
             'application/json' => assessment
           }
         end


           # expect(reply.dig('attributes', 'version')).to eq('1')
           # expect(reply.dig('relationships', 'solutions', 'data').length).to eq(
                                                                               #3)
       end

     end



   end

end
