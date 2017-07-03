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

  namespace :api do
    namespace :v1 do
      resources :restaurants, only: [] do
        resources :reviews, only: [] do
          resources :votes, only: [:create]
        end
      end
    end
  end
end
