Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  authenticate :user do
    resources :file_uploads, only: [:index, :new, :create, :destroy] do
      member do
        post :share
      end
    end
  end

  get 'public/:token', to: 'public_files#show', as: 'public_file'
  get 'public/:token/download', to: 'public_files#download', as: 'download_public_file'

  root to: "file_uploads#index"
end
