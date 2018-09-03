require_relative '../../../swagger_codegen'

namespace 'generate:client' do


  desc <<-DESC.strip_heredoc
    Generate the Ruby API client in the clients directory.
  DESC
  task :ruby, [:api_major_version] => :environment do |tt,args|
    version = args[:api_major_version] || '1'

    gem_name = 'a15k_client'
    output_dir = nil

    SwaggerCodegen.execute(version) do |json|
      api_exact_version = json[:info][:version]
      output_dir = "#{Rails.application.root}/clients/#{api_exact_version}/ruby"
      FileUtils::rm_rf(output_dir)
      {
        cmd_options: %w[-l ruby],
        output_dir: output_dir,
        config: {
          gemName: gem_name,
          moduleName: 'A15kClient',
          gemVersion: json[:info][:version]
        }
      }
    end

    # Code to remove the locked version for the json gem from the client
    gemspec_filename = File.join(output_dir, gem_name + ".gemspec")
    original_contents = File.read(gemspec_filename)
    new_contents = original_contents.gsub(
      "s.add_runtime_dependency 'json', '~> 2.1', '>= 2.1.0'",
      "s.add_runtime_dependency 'json'"
    )
    File.open(gemspec_filename, "w") {|file| file.puts new_contents}
  end
end
