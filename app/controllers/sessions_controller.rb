
class SessionsController < ApplicationController
  include OauthHelper

  def new
    render layout: 'login'
  end

  def facebook_login
    redirect_to get_facebook_url
  end

  def callback
    if params[:code] && params[:code] != ''
      graph = Facebook::Graph.new(auth_code: params[:code]).set_access_token
      authenticate('facebook', graph)
    else
      redirect_to '/login', notice: "There was an error trying to login with you Facebook account."
    end
  end

  def destroy
    session[:user_id] = nil
    cookies.delete(:fb_access_token)
    redirect_to login_path
  end

  private

  def authenticate(provider, graph_object)
    authorization = Authorization.find_by_provider_and_uid(provider, graph_object.get_user_data['id'])
    if authorization
      set_session_and_token_and_redirect(authorization.user.id, graph_object.access_token,  "Welcome Back, #{authorization.user.name}!")
    else
      user = User.new(
          name: graph_object.get_user_data['name'],
          email: graph_object.get_user_data['email']
      )
      user.authorizations.build(provider: provider, uid: graph_object.get_user_data['id'])
      if user.save
        set_session_and_token_and_redirect(user.id, graph_object.access_token, "Thanks for signup, #{user.name}")
      end
    end
  end

  def set_session_and_token_and_redirect(user_id, access_token, message)
    session[:user_id] = user_id
    cookies.signed[:fb_access_token] = access_token
    redirect_to root_path, notice: message
  end
end