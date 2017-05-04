namespace :nvm do
  task :load do
    comment %{Loading nvm}
    command %{[ -s "#{fetch(:nvm_path)}/nvm.sh" ] && . "#{fetch(:nvm_path)}/nvm.sh"}
  end
end
