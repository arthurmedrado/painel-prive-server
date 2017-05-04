class SessionsController < ApplicationController
  skip_before_action :needs_login, only: [:new, :create, :destroy]
  
  def new
    respond_to do |format|
      format.js
      format.html{
        return redirect_to root_path unless current_admin.nil?
      }
    end
  end
  
  def create
    admin = Admin.authenticate(params[:username], params[:password])
    if !admin.nil?
      create_session admin
      notice_flash style: :success, header: 'Sucesso!', message: "Logado como #{admin.name}!"
      redirect_to root_path
    else
      notice_flash style: :danger, header: 'Erro!', message: 'Usuário ou senha inválidos!'
      render :new, layout: ( request.subdomain.empty? ? 'application' : request.subdomain ), turbolinks: true
    end
  end
  
  def destroy
    destroy_session
    notice_flash style: :success, header: 'Sucesso!', message: 'Você foi deslogado!'
    redirect_to login_path
  end

end
