Rails.application.routes.draw do
  root :to=>'home#index', :as=>:home
  resources :books do
    resources :slams
  end
  match '/users/search', :to => 'users#search', :as => :user_search, :via => [:get, :post]
  match '/users/:user_id', :to => redirect('http://www.google.com'), :via => [:get, :post]
  match '/users/:user_id/books', :to => 'users#books', :as => :user_books, :via => [:get, :post]
  match '/users/:user_id/about', :to => 'users#about', :as => :user_about, :via => [:get, :post]
  match '/users/:user_id/slams', :to => 'users#slams', :as => :user_slams, :via => [:get, :post]
  match '/users/:user_id/following', :to => 'users#following', :as => :user_following, :via => [:get, :post]
  # Follow a user
  match '/users/:user_id/follow', :to=>'users#follow', :as => :user_follow, :via => [:get, :post]
  # UnFollow a user
  match '/users/:user_id/unfollow', :to=>'users#unfollow', :as => :user_unfollow, :via => [:get, :post]    
  match '/newsfeeds', :to => 'news_feeds#index', :as => :news_feeds, :via => [:get, :post]

  # Routes for omniauth
  match '/auth/:provider/callback', :to => 'sessions#create', :via => [:get, :post]
  match '/auth/failure', :to => redirect('/') , :via => [:get, :post]
  match '/signout', :to => 'sessions#destroy' , :via => [:get, :post]
end
