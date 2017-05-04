# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

namespace :uploads do
  task cleanup: :environment do
    count = 0
    puts "Removed #{count} file#{count == 1 ? '' : 's'}"
  end
end
