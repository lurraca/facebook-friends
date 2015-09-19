
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
    else
      redirect_to '/login', notice: "There was an error trying to login with you Facebook account."
    end
  end

  end
end