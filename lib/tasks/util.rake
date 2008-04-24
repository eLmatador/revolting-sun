# = Revolting Sun
# Web-based, multiplayer X-COM clone.
# Website:: http://revolting-sun.rubyforge.org/
# Copyright:: WTFPL <http://sam.zoy.org/wtfpl/>

require 'tasks/rails'

# A few helpful Rake tasks.
namespace :util do
  desc 'Clear out the log/ and tmp/ directories'
  task :cleanup => :environment do
    header('Clearing logs.')
    Rake::Task['log:clear'].invoke

    header('Clearing tmp.')
    Rake::Task['tmp:clear'].invoke
  end

  desc 'Reset the database and load all fixtures'
  task :setup_dev_env => :environment do
    header('Resetting database.')
    Rake::Task['db:reset'].invoke

    header('Migrating database to current.')
    Rake::Task['db:migrate'].invoke

    header('Loading fixtures.')
    Rake::Task['db:fixtures:load'].invoke
  end
end

private

# Ask for confirmation.  Returns true/false
def confirm(message, options = {})
  confirm_message = options[:confirm_message] || 'Are you sure?'
  banner = options[:banner] || false
  if banner
    header(message) # print with header
    print "#{confirm_message} (yes/no) "
    choice = STDIN.gets.chomp
  else
    puts message
    print "#{confirm_message} (yes/no) "
    choice = STDIN.gets.chomp
  end

  case choice
  when 'yes'
    return true
  else
    puts 'Aborted'
  end
end

# Displays +message+ inside a formatted header.
def header(message = nil)
  raise ArgumentError, 'No message passed to header.' unless message
  puts "\n"
  puts '+---'
  puts "| #{message}"
  puts '+---'
rescue ArgumentError => error
  print "#{__FILE__}:#{__LINE__}: "
  puts error.message
  puts '-- Backtrace --'
  puts error.backtrace
  exit
end