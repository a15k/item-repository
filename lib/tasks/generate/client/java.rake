require_relative '../../../swagger_codegen'

namespace 'generate:client' do


  desc <<-DESC.strip_heredoc
    Generate the Java API client in the clients directory.
  DESC
  task :java, [:api_major_version] => :environment do |tt,args|
    version = args[:api_major_version] || '1'

    package = 'a15kClient'
    package = "org.a15k.client.v#{version}"
    client_package = "#{package}.client"
    output_dir = nil

    # options are modeled after example given in:
    # https://voicebase.readthedocs.io/en/v3/how-to-guides/swagger-codegen.html
    SwaggerCodegen.execute(version) do |json|
      api_exact_version = json[:info][:version]
      output_dir = "#{Rails.application.root}/clients/#{api_exact_version}/java"
      FileUtils::rm_rf(output_dir)
      {
        cmd_options: %w[-l java],
        output_dir: output_dir,
        config: {
          developerName: 'A15K',
          developerEmail: 'contact@a15k.org',
          developerOrganization: 'A15K',
          developerOrganizationUrl: 'https://a15k.org',
          invokerPackage: client_package,
          apiPackage: "#{client_package}.api",
          modelPackage: "#{client_package}.model",
          groupId: package,
          artifactId: "v#{version}client"
        }
      }
    end

  end
end
