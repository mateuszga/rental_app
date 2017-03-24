Rails.application.routes.draw do
  devise_for :users
  resources :cars do
  	resources :bookings
  end

  root 'cars#index'
end
