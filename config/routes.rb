Rails.application.routes.draw do
  root :to=>'home#index', :as=>:home
  resources :books do
    resources :slams
  end
end
