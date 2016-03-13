Rails.application.routes.draw do

  devise_for :users, defaults: { format: :json }, controllers: { sessions: "api/users/sessions", registrations: "api/users/registrations" }

  if Rails.env.development?
    match '/stubs/*path', to: 'stubs#show', via: :get
  end

  root 'pages#index'
  namespace :api, defaults: { format: :json } do
    resources :wifs, only: [:index, :show, :destroy]
    resources :assets do
      get :issue, to: "assets#issue"
      post :send_asset, to: "assets#send_asset"
    end
  end
end
