module Facebook
  class Graph
    attr_reader :auth_code
    attr_accessor :access_token

    def initialize(auth_code: '', access_token: '')
      @auth_code = auth_code
      @access_token = access_token
    end

    def set_access_token
      response = HTTParty.get(access_token_url)
      @access_token = parse_access_token(response)
      self
    end

    def get_user_data
      HTTParty.get(user_data_url)
    end

    def get_user_friends
      (taggable_friends || user_friends).map { |friend| Friend.new(friend) }

    end

    private

    def access_token_url
      "https://graph.facebook.com/oauth/access_token?client_id=#{ENV['FB_APP_ID']}&" <<
          "client_secret=#{ENV['FB_APP_SECRET']}&"<<
          "redirect_uri=#{ENV['CALLBACK_HOST']}/login/facebook/callback&code=#{@auth_code}"
    end

    def parse_access_token(response)
      URI.escape(response.split('&')[0].split('access_token=')[1])
    end

    def user_data_url
      "https://graph.facebook.com/me/?fields=email,name,friends,picture&access_token=#{@access_token}"
    end

    def taggable_friends
      HTTParty.get(user_taggable_friends_url)["data"]
    end

    def user_friends
      HTTParty.get(user_friends_url)["data"]
    end

    def user_taggable_friends_url
      "https://graph.facebook.com/me/taggable_friends?fields=email,name,picture&access_token=#{@access_token}"
    end

    def user_friends_url
      "https://graph.facebook.com/me/friends?fields=email,name,picture&access_token=#{@access_token}"
    end

  end
end