require 'erb'
require 'yaml'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'

Dir["#{File.dirname(__FILE__)}/deploy/*.rb"].each { |file| require file }

def template(filename)
  filepath = File.expand_path("../deploy/templates/#{filename}", __FILE__)
  ERB.new(File.read( filepath )).result(binding).gsub('$', '\\$')
end

set :domain, 'prive.anfeli.com.br'
set :cdn_domain, 'cdn.prive.anfeli.com.br'
set :deploy_to, '/home/deployer/prive'
set :cdn_path, '/home/deployer/cdn'
set :repository, 'git@bitbucket.org:callnews/prive-server.git'
set :branch, 'master'

set :user, 'deployer'          # Username in the server to SSH to.
#   set :port, '30000'           # SSH port number.
#   set :forward_agent, true     # SSH forward_agent.

# Npm options
set :npm_bin, 'npm'
set :npm_options, '--production -q -s'
# Nvm options
set :nvm_path, '/home/deployer/.nvm'

# SSL Domains to sign
set :ssl_domains, [fetch(:domain), fetch(:cdn_domain)]

# New relic options
set :newrelic_appname, "Hoteis Prive"
set :newrelic_license_key, YAML.load_file(File.expand_path('../newrelic.yml', __FILE__))["common"]["license_key"]
set :newrelic_user, `git --no-pager log --format="%aN" -n 1`.strip
set :newrelic_revision, `git --no-pager log --format="%H" -n 1`.strip
set :newrelic_desc, `git --no-pager log --format="%s" -n 1`.strip

# shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
set :shared_dirs, fetch(:shared_dirs, []).push('tmp/pids', 'tmp/sockets', 'config/nginx')
set :shared_files, fetch(:shared_files, []).push('config/application.yml', 'config/database.yml', 'config/newrelic.yml', 'config/secrets.yml', 'config/unicorn.rb')

# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  invoke :'rbenv:load'
  invoke :'nvm:load'
end

# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task setup: [:environment] do
  ruby_version = File.read(File.expand_path('../../.ruby-version', __FILE__)).gsub("ruby-", "").strip
  comment %{Installing ruby (#{ruby_version})}
  command %{rbenv install -s #{ruby_version}}
  command %{rbenv local #{ruby_version}}
  
  comment %{Installing bundler}
  command %{gem install bundler}
  
  comment %{Creating CDN path}
  command %{mkdir -p #{fetch(:cdn_path)}}
  
  invoke :'nginx:configure'
  invoke :'nginx:restart'
  
  invoke :'logrotate:setup'
  
  comment %{Dont forget to create or edit the files below}
  comment fetch(:shared_files, [])
end

desc "Deploys the current version to the server."
task :deploy do
  # uncomment this line to make sure you pushed your local branch to the remote origin
  # invoke :'git:ensure_pushed'
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'npm:install'
    invoke :'rails:assets_precompile'
    invoke :'assets:publish'
    invoke :'deploy:cleanup'

    on :launch do
      invoke :'assets:uploads:cleanup'
      invoke :'unicorn:restart'
    end
  end

  # you can use `run :local` to run tasks on local machine before of after the deploy scripts
  run :local do
    comment 'done'
    invoke :'newrelic:notice_deployment'
  end
end

# For help in making your deploy script, see the Mina documentation:
#
#  - https://github.com/mina-deploy/mina/tree/master/docs
