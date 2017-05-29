Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  get 'rankings/good', to: 'rankings#good'
  get 'rankings/pv', to: 'rankings#pv'

  post 'uploads', to: 'images#create'

  resources :users, only: [:show, :new, :create]
  resources :movies, only: [:index, :show]
  resources :articles
  resources :user_articles, only: [:create, :destroy]
  resources :rooms, only: [:show]

  get '*path', to: 'application#render_404'
end
