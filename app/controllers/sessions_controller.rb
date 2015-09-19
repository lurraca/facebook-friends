class SessionsController < ApplicationController

  def new
    render layout: 'login'
  end

  def facebook_login
  end

  def callback
    if params[:code] && params[:code] != ''
    else
      redirect_to '/login', notice: "There was an error trying to login with you Facebook account."
    end
  end

  end
end