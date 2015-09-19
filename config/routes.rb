Rails.application.routes.draw do

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  get '/login' => 'sessions#new'
  get '/logout' => 'sessions#destroy'

  get '/login/facebook' => 'sessions#facebook_login'
  get '/login/facebook/callback' => 'sessions#callback'

end
