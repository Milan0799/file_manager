Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  # Custom Devise route for checking email availability
  devise_scope :user do
    get '/check_email', to: 'registrations#check_email'
  end

  # Reveal health status
  get "up" => "rails/health#show", as: :rails_health_check

  # Authenticated routes
  authenticate :user do
    resources :file_uploads, only: [:index, :new, :create, :destroy] do
      member do
        post :share
      end
    end
  end

  # Public file view
  get 'public/:token', to: 'file_uploads#public_show', as: 'public_file'

  # Root path
  root to: "file_uploads#index"
end
