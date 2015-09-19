
module OauthHelper
  def get_facebook_url
    "https://www.facebook.com/dialog/oauth?client_id=#{ENV['FB_APP_ID']}&redirect_uri=#{ENV['CALLBACK_HOST']}/login/facebook/callback&scope=email,user_friends"
  end
end