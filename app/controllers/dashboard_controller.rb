
class DashboardController < ApplicationController
  before_filter :authorize
  def index
    graph = Facebook::Graph.new(access_token: cookies.signed[:fb_access_token])
    @friends = graph.get_user_friends
  end
end