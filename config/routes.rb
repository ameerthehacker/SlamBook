Rails.application.routes.draw do
  root :to=>'home#index', :as=>:home
  resources :books do
    post '/slams/new', :to => 'slams#new'
    post '/slams/:id', :to => 'slams#show'
    resources :slams
  end
  get '/users/search', :to => 'users#search', :as => :user_search
  get '/users/:user_id', :to => 'users#books', :as => :user
  get '/users/:user_id/books', :to => 'users#books', :as => :user_books
  get '/users/:user_id/about', :to => 'users#about', :as => :user_about
  get '/users/:user_id/slams', :to => 'users#slams', :as => :user_slams
  get '/users/:user_id/following', :to => 'users#following', :as => :user_following
  # Follow a user
  get '/users/:user_id/follow', :to=>'users#follow', :as => :user_follow
  # UnFollow a user
  get '/users/:user_id/unfollow', :to=>'users#unfollow', :as => :user_unfollow   
  get '/newsfeeds', :to => 'news_feeds#index', :as => :news_feeds
  # Routes for omniauth
  match '/auth/:provider/callback', :to => 'sessions#create', :via => [:get, :post]
  match '/auth/failure', :to => redirect('/') , :via => [:get, :post]
  match '/signout', :to => 'sessions#destroy' , :via => [:get, :post]
end
