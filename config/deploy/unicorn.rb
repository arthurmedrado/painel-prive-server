namespace :unicorn do
  %w[start stop restart status].each do |action|
  desc "#{action.capitalize} unicorn service"
    task action do
      comment %{#{action.capitalize}ing unicorn server}
      command %{sudo systemctl #{action} unicorn}
    end
  end
end
