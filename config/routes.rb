Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    resources :todos do
      resources :items
      resources :orders
      resources :customers
    end

    resources :projects do
      resources :employees
    end

    resources :notes do
      resources :posts
    end

    post 'auth/login', to: 'authentication#authenticate'
    post 'signup', to: 'userbs#create'
    post 'email', to: 'emails#create'
    root :to => 'index#index'
    get 'showAll', to: 'projects#showall'
end
