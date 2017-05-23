Rails.application.routes.draw do
  root :to=>'home#index', :as=>:home, :via => [ :get, :post ]
  resources :books do
    post '/slams/new', :to => 'slams#new'
    post '/slams/:id', :to => 'slams#show'
    resources :slams
  end
  get '/users/search', :to => 'users#search', :as => :user_search
  get '/users/:user_id', :to => 'users#books', :as => :user
  match '/users/:user_id/books', :to => 'users#books', :as => :user_books, :via => [:get, :post]
  match '/users/:user_id/books/:book_id', :to => 'users#book', :as => :user_book, :via => [:get, :post]
  get '/users/:user_id/slams', :to => 'users#slams', :as => :user_slams
  get '/users/:user_id/following', :to => 'users#following', :as => :user_following
  # Follow a user
  get '/users/:user_id/follow', :to=>'users#follow', :as => :user_follow
  # UnFollow a user
  get '/users/:user_id/unfollow', :to=>'users#unfollow', :as => :user_unfollow   
  get '/newsfeeds', :to => 'news_feeds#index', :as => :news_feeds
  # Routes for omniauth
  match '/auth/:provider/callback', :to => 'sessions#create', :via => [:get, :post]
  match '/auth/failure', :to => 'sessions#failure' , :via => [:get, :post]
  match '/signout', :to => 'sessions#destroy' , :via => [:get, :post]
end
