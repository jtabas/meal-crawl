Rails.application.routes.draw do
  root "restaurants#index"

  namespace :api do
    namespace :v1 do
      resources :restaurants, only: [:index]
    end
  end

  devise_for :users,
    controllers: {
    sessions: 'users/sessions'
  }

  resources :restaurants, only: [:index, :show] do
  end

  resources :users, except: [:index, :new, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
