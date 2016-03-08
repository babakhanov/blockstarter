Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'
  namespace :api, defaults: { format: :json } do
    resources :assets
  end
end
