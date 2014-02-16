# encoding: utf-8
class TodoApi::V1::Token < Grape::API

  resource :token do

    ## CREATE
    desc "Create new token", {
      entity: Entity::User,
      notes: 'Generate auth token for user'
    }
    params do
      requires :email, type: String, desc: "Email"
      requires :password, type: String, desc: "Password"
    end
    post do
      user = User.find_by(email: params[:email]) rescue nil 
      
      if user && user.valid_password?(params[:password])
        user.ensure_authentication_token!
        present user, with: Entity::User
      else
        error! 'Unauthorized, invalid password email', 401
      end
    end

    ## DELETE
    desc "Revoke token"
    delete do
      authenticated?
      unless current_user.reset_authentication_token!
        error! 'Could not process', 501
      end
    end
  end
end