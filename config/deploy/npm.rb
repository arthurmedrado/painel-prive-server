namespace :npm do
  desc 'Install node modules using Npm.'
  task install: :environment do
    comment %{Installing node modules using Npm}
    command %{#{fetch(:npm_bin)} install #{fetch(:npm_options)}}
  end
end
