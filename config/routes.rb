Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'todos#index'


  resources :todos do
    resources :items
  end
  resources :farms do
    resources :animals
  end
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
