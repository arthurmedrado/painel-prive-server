namespace :newrelic do
  desc 'Record a deployment in New Relic (newrelic.com)'
  task :notice_deployment do
    require 'new_relic/cli/command'
    rails_env = fetch(:newrelic_rails_env, fetch(:rails_env, 'production'))
    
    begin
      # allow overrides to be defined for revision, description, changelog, appname, and user
      revision    = fetch(:newrelic_revision, nil)
      description = fetch(:newrelic_desc, nil)
      changelog   = fetch(:newrelic_changelog, nil)
      appname     = fetch(:newrelic_appname, nil)
      user        = fetch(:newrelic_user, nil)
      license_key = fetch(:newrelic_license_key, nil)
      
      deploy_options = {
        environment: rails_env, revision: revision,
        changelog: changelog, description: description,
        user: user, appname: appname, license_key: license_key
      }
      
      comment 'Uploading deployment information to New Relic'
      NewRelic::Cli::Deployments.new(deploy_options).run
      print_stdout 'Uploaded deployment information to New Relic'
      
    rescue NewRelic::Cli::Command::CommandFailure => e
      print_error e.message
    rescue => e
      print_error "Error creating New Relic deployment (#{e})\n#{e.backtrace.join("\n")}"
    end
  end
end
