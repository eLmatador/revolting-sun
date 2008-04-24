# = Revolting Sun
# Web-based, multiplayer X-COM clone.
# Website:: http://revolting-sun.rubyforge.org/
# Copyright:: WTFPL <http://sam.zoy.org/wtfpl/>

require 'tasks/rails'

# The local directory to store the website files.
LOCAL_SITE = "#{RAILS_ROOT}/doc/rubyforge.site"

# The remote directory the files will be scp'ed to.
REMOTE_SITE = 'revolting-sun.rubyforge.org/var/www/gforge-projects/revolting-sun'

# Issue and Rails app doc directories.
ISSUE_DIR = "#{RAILS_ROOT}/doc/issues"
DOC_DIR = "#{RAILS_ROOT}/doc/app"

# Rake tasks for dealing with the website.
namespace :site do
  # Copies the issue and docs to the site directory.
  task :setup_site_dir => [ 'doc:app', 'issues:report'] do
    header('Copying issue and docs to the site directory.')
    puts "cp -r #{ISSUE_DIR} #{DOC_DIR} #{LOCAL_SITE}"
  end

  desc 'Upload the issues and docs to the website'
  task :upload => :setup_site_dir do
    header('Uploading local site to remote site.')
    puts "scp -r #{ISSUE_DIR} #{REMOTE_SITE}"
    puts "scp -r #{DOC_DIR} #{REMOTE_SITE}"
  end
end
