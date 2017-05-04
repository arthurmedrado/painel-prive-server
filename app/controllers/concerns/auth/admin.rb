module Auth
  module Admin
    extend ActiveSupport::Concern

    included do
      include Auth::Base
      helper_method :current_admin
    end

    class_methods do
      def needs_admin_login(options = {})
        before_action :restrict_admin_access, options
      end
    end

    # Gets the current admin from the session
    def current_admin
      @current_admin ||= current_user.loggable if !current_admin.nil? && current_admin.is_admin?
    end

    def restrict_admin_access
      if restricted_access
        return false
      elsif current_admin.nil?
        destroy_session
        notice_flash style: :warning, header: 'Atenção!', message: 'Você não tem autorização para acessar esta página!'
        redirect_to login_path, status: 303, turbolinks: true
        return false
      end
    end

  end
end
