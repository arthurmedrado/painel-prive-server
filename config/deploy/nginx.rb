namespace :nginx do
  task :configure do
    comment %{Removing old config files}
    command %{sudo rm -f /etc/nginx/sites-enabled/*}

    comment %{Placing new config files}

    comment %{    default}
    command %{cat > #{fetch(:shared_path)}/config/nginx/default << EOF
#{template 'default.erb'}
EOF}

    comment %{    000-prive}
    command %{cat > #{fetch(:shared_path)}/config/nginx/000-prive << EOF
#{template '000-prive.erb'}
EOF}

    comment %{    unicorn.service}
    command %{cat > #{fetch(:shared_path)}/config/nginx/unicorn.service << EOF
#{template 'unicorn.service.erb'}
EOF}

    comment %{    unicorn.rb}
    command %{cat > #{fetch(:shared_path)}/config/unicorn.rb << EOF
#{template 'unicorn.rb.erb'}
EOF}

    comment %{Symlinking}

    comment %{    default}
    command %{sudo ln -s #{fetch(:shared_path)}/config/nginx/default /etc/nginx/sites-enabled/default}

    invoke :'nginx:restart'
    invoke :'nginx:ssl:configure'

    comment %{Symlinking}

    comment %{    000-prive}
    command %{sudo ln -s #{fetch(:shared_path)}/config/nginx/000-prive /etc/nginx/sites-enabled/000-prive}

    comment %{    unicorn.service}
    command %{sudo systemctl disable unicorn}
    command %{sudo rm -f /lib/systemd/system/unicorn.service}
    command %{sudo cp #{fetch(:shared_path)}/config/nginx/unicorn.service /lib/systemd/system/unicorn.service}
    command %{sudo systemctl daemon-reload}
    command %{sudo systemctl start unicorn}
    command %{sudo systemctl enable unicorn}
  end

  task :restart do
    command %{sudo service nginx restart}
  end

  namespace :ssl do
    task :configure do
      comment %{Configuring nginx SSL}
      command %{
        if [ ! -f /etc/ssl/certs/dhparam.pem ]; then
          sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
        fi
      }

      domains = ([''] + fetch(:ssl_domains, [])).join ' -d '
      command %{
        sudo letsencrypt certonly --webroot -w /var/www/html #{domains} -n --agree-tos -m arthur.m.celedonio@gmail.com
      }
    end
  end
end
