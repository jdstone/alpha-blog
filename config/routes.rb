Rails.application.routes.draw do
  root 'articles#index'
  get 'about', to: 'pages#about'
  resources :articles
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  # get 'logout', to: 'sessions#logout'
  # get 'logout', to: 'sessions#destroy'
end
