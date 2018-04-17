require 'open-uri'
require 'fileutils'
require 'tempfile'

BINDINGS_GEM_NAME = "a15k_repository_api_models"

def generate_model_bindings(version)
  # Get the swagger data so we can extract the current API version

  swagger_data = Swagger::Blocks.build_root_json(
    "Api::Docs::V#{version}Controller::SWAGGERED_CLASSES".constantize
  )

  api_exact_version = swagger_data[:info][:version]

  # Prep the tmp dir

  output_dir = "#{Rails.application.root}/tmp/ruby-models/#{api_exact_version}"
  FileUtils::rm_rf(output_dir)
  FileUtils::mkdir_p(output_dir)

  # Write the swagger data to a JSON file (so we don't have to run the web server
  # to provide it to swagger-codegen)

  swagger_json_file_name = "#{output_dir}/swagger.json"
  File.open(swagger_json_file_name, "w") {|f| f.write(swagger_data.to_json)}

  # Create a config.json file to control the generation


  #config_file_name = "#{output_dir}/config.json"

  Tempfile.open(['config', '.json']) do |config_file|

    config_file.write({
      gemName: BINDINGS_GEM_NAME,
      moduleName: "Api::V#{version}::Bindings",
      gemVersion: api_exact_version,
    }.to_json)
    config_file.flush

    # Build and run the swagger-codegen command
    cmd = <<-DESC.strip_heredoc
      swagger-codegen generate -i #{swagger_json_file_name} \
      -l ruby -Dmodels -o #{output_dir} -c #{config_file.path}
    DESC

    puts cmd
    puts `#{cmd}`
  end

  # Move the models to the app/bindings directory

  bindings_dir = "#{Rails.application.root}/app/bindings/api/v#{version}/bindings"
  FileUtils::rm_rf(bindings_dir)
  FileUtils::mkdir_p(bindings_dir)
  FileUtils::cp(Dir.glob("#{output_dir}/lib/#{BINDINGS_GEM_NAME}/models/*.rb"), bindings_dir, verbose: true)
end


namespace :bindings do
  namespace :model do

    desc <<~DESC.strip_heredoc
      Generate the Ruby API model bindings in the app/bindings directory.  swagger-codegen
      must be installed.  Run like `rake model_bindings:generate[1]` for version 1 API.
    DESC
    task :generate, [:api_major_version] => :environment do |tt, args|
      generate_model_bindings args[:api_major_version] || '1'
    end

  end
end
