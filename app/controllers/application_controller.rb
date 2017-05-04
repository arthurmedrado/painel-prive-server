class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :needs_login, except: :missing_action
  
  def missing_action
    not_found
  end
  
  def pagetitle=(title)
    @pagetitle = title
  end
  
  def current_admin
    @current_admin ||= Admin.where(id: session[:admin_id]).first if session[:admin_id]
  end
  helper_method :current_admin
  
  def create_session(admin)
    session[:admin_id] = admin.id
    session[:expires_at] = (Time.now + 30.minutes).to_i
  end
  
  def destroy_session
    reset_session
    session[:admin_id] = nil
    session[:expires_at] = nil
  end
  
  def needs_login
    if current_admin.nil?
      login_is_needed
      return false
    end
    if session[:expires_at].to_i < Time.now.to_i
      session_did_timeout
      return false
    end
    session[:expires_at] = session[:expires_at] + 30.minutes
    return true
  end
  
  def notice_flash(options)
    f = flash[:notice] || []
    f << options
    flash[:notice] = f
  end
  
  def notice_flash_now(options)
    f = flash.now[:notice] || []
    f << options
    flash.now[:notice] = f
  end
  
  def alert_link_to(text, url)
    view_context.link_to text, url, class: 'alert-link'
  end
  
private
  
  def not_found
    raise ActionController::RoutingError.new %Q{No route matches [#{request.method}] "#{request.path}"}
  end
  
  # Session alerts
  def login_is_needed
    destroy_session
    notice_flash style: :warning, header: 'Atenção!', message: 'Você precisa estar logado para acessar esta área!'
    redirect_to login_path, status: 303, turbolinks: true
  end
  
  def session_did_timeout
    destroy_session
    notice_flash style: :danger, header: 'Sua sessão expirou!', message: 'Para continuar efetue o login!'
    redirect_to login_path, status: 303, turbolinks: true
  end
  
end
