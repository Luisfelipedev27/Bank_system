Rails.application.routes.draw do
  get 'bank_accounts/show'
  get 'sessions/new'
  root 'static_pages#home'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :bank_accounts, only: [:show]

  namespace :api do
    namespace :v1 do
      post "bank_accounts/new_transaction", to: "bank_accounts#new_transaction"
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
