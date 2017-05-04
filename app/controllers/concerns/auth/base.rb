module Auth
  module Base
    extend ActiveSupport::Concern

    included do
      helper_method :current_admin
    end

    class_methods do
      def needs_login(options = {})
        before_action :restrict_access, options
      end
    end

    # Gets the current admin from session
    def current_admin
      @current_admin ||= Admin.where(id: session[:login_id]).first if session[:login_id]
    end

    # before_action to restrict access to logged in Admins
    def restrict_access
      return false if restricted_access
    end

    # Method to validate and select message on admin logged out
    def restricted_access
      if current_admin.nil?
        login_is_needed
        return true
      end
      if session[:expires_at].to_i < Time.now.to_i
        session_did_timeout
        return true
      end
      session[:expires_at] = session[:expires_at] + session_extend
      return false
    end

    # Helper to warn about login required
    def login_is_needed
      destroy_session
      notice_flash style: :warning, header: 'Atenção!', message: 'Você precisa estar logado para acessar esta área!'
      redirect_to login_path, status: 303, turbolinks: true
    end

    # Helper to warn about session timeout
    def session_did_timeout
      destroy_session
      notice_flash style: :danger, header: 'Sua sessão expirou!', message: 'Para continuar efetue o login!'
      redirect_to login_path, status: 303, turbolinks: true
    end

    # Session helpers

    # Create a session for a given admin
    def create_session(admin, keep)
      session[:login_id] = admin.id
      session[:expires_at] = keep ? session_keep_timeout : admin.session_timeout
    end

    # Default keep time for session
    def session_keep_timeout
      (Time.now + 1.year).to_i
    end

    # Default session extend on every access
    def session_extend
      30.minutes
    end

    # Remove a session
    def destroy_session
      reset_session
      session[:login_id] = nil
      session[:expires_at] = nil
    end

    # Returns the root URL for a given admin
    def root_for(admin)
        admin_root_url
    end

  end

end
