require_relative '../demo'

desc <<-DESC.strip_heredoc
  Generate demo data
DESC
task :demo, [:count] => :environment do |tt,args|

  members = Member.where('name like ?', 'Demo%')
  members += (members.count .. 3).map do |i|
    Member.create!(name: "Demo #{i}", website: 'openstax.org')
  end

  members.each do |member|
    demo.member = member
    (members.assessments.count .. args[:count]).each do
      demo.create_assessment(solutions_count: (rand * 3).round + 2)
    end
  end

end
