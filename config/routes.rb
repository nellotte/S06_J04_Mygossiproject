Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  
  get "up" => "rails/health#show", as: :rails_health_check
  get '/team', to: 'public#team'
  get '/contact', to: 'public#contact'
 
  get '/home', to: 'home#home'

  resources :gossips do
    resources :comments,  only: [:index, :new, :create, :destroy]
  end
  
  resources :users
  resources :cities

  resources :sessions, only: [:new, :create, :destroy]
  
  
end
