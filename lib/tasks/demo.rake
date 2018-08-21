require_relative '../demo'

desc <<-DESC.strip_heredoc
  Generate demo data
DESC
task :demo, [:count] => :environment do |tt,args|

  members = Member.where('name like ?', 'Demo%')
  members += (members.count..3).map do |i|
    Member.create!(name: "Demo #{i}", website: 'openstax.org')
  end

  [members.first].each do |member|
    demo = Demo.new(member: member)
    (args[:count] || 1).to_i.times do
      assessment = demo.create_assessment(solutions_count: (rand * 3).round + 2)
      puts assessment.preview_html if ENV['VERBOSE']
    end
  end

end
