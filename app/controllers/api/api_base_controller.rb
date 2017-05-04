module Api
  class ApiBaseController < ApplicationController
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :null_session
    
    skip_before_action :needs_login
    
    # Retorna o usuario que fez a requisição ou nil
    def current_user
      return @current_user unless @current_user.nil?
      return nil if request.headers['Authorization'].nil?
      return nil if valid_auth_token.nil?
      
      @current_user = User.authenticate(valid_auth_token)
    end
    # Cache para o usuario atual
    def current_user=(user)
      @current_user = user
    end

  private
    def valid_auth_token
      @version = request.headers['X-VersionApp']
      
      @api_version = request.headers['Accept'].match(/\Aapplication\/vnd.hoteisprive.v(\d{1,})\z/).captures.first
      
      @token, @version_hash = request.headers['Authorization'].match(/\AHoteisPrive token=([0-9a-f]*), version=(.*)\z/).captures
      saltedVersion = "HoteisPrive-#{@api_version}-#{@token}-#{@version}"
      
      # Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), @version, saltedVersion)).strip()
      if @version_hash == OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), @version, saltedVersion)
        @token
      else
        nil
      end
    end
    
    def restrict_access
      if current_user.nil?
        render status: 200, json: { status: 401 }
        return false
      end
    end
    
  end
end
