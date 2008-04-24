# = Revolting Sun
# Web-based, multiplayer X-COM clone.
# Website:: http://revolting-sun.rubyforge.org/
# Copyright:: WTFPL <http://sam.zoy.org/wtfpl/>

require 'tasks/rails'

# The directory where the HTML issue report will be stored.
ISSUE_DIR = "#{RAILS_ROOT}/doc/issues"

# 'rake issues' will just list them.
desc 'List current issues'
task :issues do
  Rake::Task['issues:list'].invoke
end

# Rake tasks for dealing with ditz issues.
namespace :issues do
  desc 'Add an issue'
  task :add do
    sh 'ditz add'
  end

  task :list do
    sh 'ditz todo'
  end

  # 'rake issues:report' will just generate the report.
  desc 'Generate issue report'
  task :report do
    Rake::Task['issues:report:generate'].invoke
  end

  namespace :report do
    task :generate do
      Rake::Task['issues:report:clear'].invoke
      header("Generating issue report in #{ISSUE_DIR}")
      sh "ditz html #{ISSUE_DIR}"
    end

    desc 'Clear the issue report'
    task :clear do
      header("Removing issue report from #{ISSUE_DIR}")
      sh "rm -rf #{ISSUE_DIR}"
    end
  end
end
