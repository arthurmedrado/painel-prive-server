namespace :logrotate do
  task :setup do
    comment %{Removing old logrotate config files}
    command %{sudo rm -f /etc/logrotate.d/prive}
    
    comment %{Placing new config files}
    comment %{    logrotate.d/prive}
    command %{cat > #{fetch(:shared_path)}/config/prive.logrotate.d << EOF
#{template 'prive.logrotate.d.erb'}
EOF}
    
    comment %{Symlinking}
    comment %{    logrotate.d/prive}
    command %{sudo ln -s #{fetch(:shared_path)}/config/prive.logrotate.d /etc/logrotate.d/prive}
  end
end
