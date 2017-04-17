Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'users/registrations' }
  root :to=>'home#index', :as=>:home
  resources :books do
    resources :slams
  end
  get '/users/:user_id/books', :to => 'books#user_books', :as => :user_boooks
end
