# config/routes.rb
Rails.application.routes.draw do
  resources :mails
  resources :todos do
    resources :items
  end
  resources :books do
    resources :pages
    end
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end