Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'users/registrations' }
  root :to=>'home#index', :as=>:home
  resources :books do
    resources :slams
  end
  get '/users/search', :to => 'users#search', :as => :user_search  
  get '/users/:user_id', :to => 'users#books', :as => :user  
  get '/users/:user_id/books', :to => 'users#books', :as => :user_books
  get '/users/:user_id/about', :to => 'users#about', :as => :user_about
  get '/users/:user_id/slams', :to => 'users#slams', :as => :user_slams     
  get '/users/:user_id/following', :to => 'users#following', :as => :user_following    
  post '/users/:user_id/update_avatar', :to => 'users#update_avatar', :as => :user_update_avatar  
  get '/users/:user_id/remove_avatar', :to => 'users#remove_avatar', :as => :user_remove_avatar 
  # Follow a user
  get '/users/:user_id/follow', :to=>'users#follow', :as => :user_follow
  # UnFollow a user
  get '/users/:user_id/unfollow', :to=>'users#unfollow', :as => :user_unfollow    
  get '/newsfeeds', :to => 'news_feeds#index', :as => :news_feeds

end
