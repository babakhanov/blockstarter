Rails.application.routes.draw do

  devise_for :users, defaults: { format: :json }, controllers: { sessions: "api/users/sessions", registrations: "api/users/registrations" }

  if Rails.env.development?
    match '/stubs/*path', to: 'stubs#show', via: :get
  end

  root 'pages#index'
  namespace :api, defaults: { format: :json } do
    resources :wifs
    resource :marketplace
    resources :assets do
      get :issue, to: "assets#issue"
      get :toggle, to: "assets#toggle"
      get :buy, to: "assets#buy"
      post :send_asset, to: "assets#send_asset"
    end
  end
end
