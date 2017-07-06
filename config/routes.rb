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

  namespace :admin do
    resources :reviews, only: [:destroy]
    resources :users, only: [:index, :show]
  end

  resources :users, except: [:index, :new, :create]
  resources :restaurants, only: [:index, :show] do
    resources :reviews, except: [:index, :show, :new]
  end

  namespace :api do
    namespace :v1 do
      resources :restaurants, only: [] do
        resources :reviews, only: [] do
        end
      end
    end
  end
end
