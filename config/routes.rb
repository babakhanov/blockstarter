Rails.application.routes.draw do

  devise_for :users, defaults: { format: :json }, controllers: { sessions: "api/users/sessions", registrations: "api/users/registrations" }

  root 'pages#index'
  namespace :api, defaults: { format: :json } do
    resources :assets
  end
end
