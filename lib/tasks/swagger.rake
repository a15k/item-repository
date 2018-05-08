namespace :swagger do

  task :write_json => :environment do
    swagger_data = Swagger::Blocks.build_root_json(
      Api::Docs::V1Controller::SWAGGERED_CLASSES
    )
    path = Rails.root.join('tmp', 'swagger.json')
    path.write(
      JSON.pretty_generate(swagger_data)
    )

    puts "Wrote swagger json to #{path}".green

  end
end
