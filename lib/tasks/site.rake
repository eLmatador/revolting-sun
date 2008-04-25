# = Revolting Sun
# Web-based, multiplayer X-COM clone.
# Website:: http://revolting-sun.rubyforge.org/
# Copyright:: WTFPL <http://sam.zoy.org/wtfpl/>

require 'tasks/rails'

# The local directory to store the website files.
LOCAL_SITE = "#{RAILS_ROOT}/doc/rubyforge.site"

# The remote directory the files will be scp'ed to.
REMOTE_SITE = 'revolting-sun.rubyforge.org:/var/www/gforge-projects/revolting-sun'

# A list of static pages to upload.
PAGES = %w{
  index.html
  robots.txt
}

# Issue and Rails app doc directories.
ISSUE_DIR = "#{RAILS_ROOT}/doc/issues"
DOC_DIR = "#{RAILS_ROOT}/doc/app"

# Rake tasks for dealing with the website.
namespace :site do
  desc 'Clear the local site directory of dynamic files'
  task :clear_local do
    sh "rm -rf #{LOCAL_SITE}/docs"
    sh "rm -rf #{LOCAL_SITE}/issues"
  end

  # Copies the issue and docs to the site directory.
  task :setup_site_dir => [ 'doc:app', 'issues:report'] do
    header('Copying issue and docs to the site directory.')
    sh "cp -r #{ISSUE_DIR} #{LOCAL_SITE}"
    sh "cp -r #{DOC_DIR} #{LOCAL_SITE}/docs"
  end

  desc 'Upload the issues and docs to the website'
  task :upload => :setup_site_dir do
    header('Uploading local site to remote site.')
    sh "cd #{LOCAL_SITE} && scp -r ./* #{REMOTE_SITE}"
  end
end
