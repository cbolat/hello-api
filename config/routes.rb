# config/routes.rb
Rails.application.routes.draw do
  resources :mails
  resources :todos do
    resources :items
  end
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end