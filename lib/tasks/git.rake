# = R-COM
# Web-based, multiplayer X-COM clone.
# Website:: http://r-com.rubyforge.org/
# Copyright:: WTFPL <http://sam.zoy.org/wtfpl/>

require 'tasks/rails'

# These tasks assume there's a task called 'git:push:repo_name'
# and that the remote repos are named as such:
REPOS = %w{ github gitorious }

# Rake tasks for dealing with the git repositories.
namespace :git do
  desc 'Push the code to all repositories'
  task :push do
    Rake::Task['git:push:all'].invoke
  end
  
  namespace :push do
    desc 'Push the code to all repositories'
    task :all do
      REPOS.each do |repo|
        Rake::Task["git:push:#{repo}"].invoke
      end
    end
    
    desc 'Push the code to githb'
    task :github do
      header('Pushing to github.')
      sh "git push github"
    end
    
    desc 'Push the code to gitorious'
    task :gitorious do
      header('Pushing to gitorious.')
      sh "git push gitorious"
    end
  end
end