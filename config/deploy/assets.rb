namespace :assets do
  desc 'Puts assets on the correct path on server'
  task :publish do
    comment %{Move assets to CDN path}
    command %{rm -f #{fetch(:cdn_path)}/assets}
    command %{cp -Rv public/assets #{fetch(:cdn_path)}}
  end
  
  namespace :uploads do
    task :cleanup do
      invoke :'rbenv:load'
      invoke :'nvm:load'
      comment %{Clean up uploads from CDN_ROOT}
      in_path(fetch(:current_path)) do
        command %{RAILS_ENV=production bundle exec rake uploads:cleanup}
      end
    end
  end
end
