require_relative '../../../swagger_codegen'

namespace 'generate:client' do


  desc <<-DESC.strip_heredoc
    Generate the Ruby API client in the clients directory.
  DESC
  task :ruby, [:api_major_version] => :environment do |tt,args|

    output_dir = "#{Rails.application.root}/clients/ruby"
    FileUtils::rm_rf(output_dir)

    SwaggerCodegen.execute(args[:api_major_version] || '1') do |json|
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
