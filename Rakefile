# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'
require 'prmd/rake_tasks/combine'
require 'prmd/rake_tasks/verify'
require 'prmd/rake_tasks/doc'

namespace :schema do
  Prmd::RakeTasks::Combine.new do |t|
    t.options[:meta] = 'config/schema-metadata.yml'    # use meta.yml if you prefer YAML format
    t.paths << 'config/schema'
    t.output_file = 'config/schema.json'
  end

  Prmd::RakeTasks::Verify.new do |t|
    t.files << 'config/schema.json'
  end

  Prmd::RakeTasks::Doc.new do |t|
    t.files = { 'config/schema.json' => 'app/views/api/index.md' }
  end

  task update: ['schema:combine', 'schema:verify', 'schema:doc']
end


Rails.application.load_tasks
