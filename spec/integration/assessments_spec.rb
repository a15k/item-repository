describe 'Assessments API' do
   after do |example|
     example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
   end

   let(:user) { FactoryBot.create(:user) }
   let(:format) { FactoryBot.create :format }
   let(:Authorization) { Access::Token.for_user(user) }

   path '/api/v1/assessments/{id}.json' do
     get 'Retrieves an assessment' do
       tags 'Assessments'
       security [Token: {}]
       produces 'application/json'
       parameter name: :id, in: :path, type: :string
       response '200', 'a assessment is returned' do

         schema json_api_show_schema(Assessment)

         let(:user) { FactoryBot.create(:user) }
         let(:Authorization) { Access::Token.for_user(user) }

         let(:assessment) { FactoryBot.create :assessment }

         let(:id) { assessment.id }
         run_test!
       end
     end
   end

   path '/api/v1/assessments.json' do

     post 'create an assessment' do

       tags 'Assessments'
       security [Token: {}]
       consumes 'application/json'
       produces 'application/json'
       parameter name: :assessment,
                 in: :body,
                 schema: json_api_create_schema(Assessment)

       response '201', 'an assessment is created' do
         let(:assessment) {
           { data: {
               attributes: {
                 format_id: format.id,
               },
               relationships: {
                 questions: {
                   data: [
                     { format_id: format.id, content: Faker::Lorem.sentence }
                   ]
                 },
                 solutions: {
                   data: 3.times.map{
                     { format_id: format.id, content: Faker::Lorem.sentence }
                   }
                 }

               }
             }
           }
         }

         run_test! do |resp|
           reply = JSON.parse(resp.body)['data']
           expect(reply.dig('attributes', 'version')).to eq('1')
           expect(reply.dig('relationships', 'solutions', 'data').length).to eq(3)
         end
       end

     end



   end

end
