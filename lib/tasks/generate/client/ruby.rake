require_relative '../../../swagger_codegen'

namespace 'generate:client' do


  desc <<-DESC.strip_heredoc
    Generate the Ruby API client in the clients directory.
  DESC
  task :ruby, [:api_major_version] => :environment do |tt,args|
    version = args[:api_major_version] || '1'
    output_dir = "#{Rails.application.root}/clients/v#{version}/ruby"
    FileUtils::rm_rf(output_dir)

    SwaggerCodegen.execute(version) do |json|
      {
        cmd_options: %w[-l ruby],
        output_dir: output_dir,
        config: {
          gemName: 'a15k_client',
          moduleName: 'A15kClient',
          gemVersion: json[:info][:version]
        }
      }
    end

  end

end
