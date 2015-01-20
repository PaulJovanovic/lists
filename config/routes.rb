Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users
  resources :lists, only: [:new, :index, :show] do
    collection do
      get :empty
    end
  end
  resources :products, only: [:show]

  namespace :admin do
    root to: "lists#index"
    resources :lists
  end

  constraints subdomain: "api" do
    scope module: :api, defaults: { format: :json } do
      namespace :v0 do
        resources :likes, only: [:create, :update]
        resources :lists do
          member do
            post :add_product
          end
        end
        resources :products
        resources :stores do
          collection do
            get :search
          end
        end
        resource :user do
          collection do
            post :like
            post :unlike
          end
        end
      end
    end
  end
end
