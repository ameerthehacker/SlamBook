Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'users/registrations' }
  root :to=>'home#index', :as=>:home
  resources :books do
    resources :slams
  end
end
