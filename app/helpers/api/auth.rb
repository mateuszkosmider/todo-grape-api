# encoding: utf-8
module Api::Auth

  def warden
    env['warden']
  end

  def authenticated?
    if warden.authenticated?
      return true
    elsif params[:api_key] and
      @current_user = User.where(authentication_token: params[:api_key]).last
    else
      error!({"error" => "Token invalid or expired"}, 401)
    end
  end

  def current_user
    @current_user
  end

end